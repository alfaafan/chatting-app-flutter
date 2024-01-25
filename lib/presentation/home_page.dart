import 'package:chatting_app_flutter/domain/usecases/get_chat_room.dart';
import 'package:chatting_app_flutter/domain/usecases/get_user.dart';
import 'package:chatting_app_flutter/presentation/chat_page.dart';
import 'package:chatting_app_flutter/presentation/common/common_app_bar.dart';
import 'package:chatting_app_flutter/shared/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> roomList = [];
  Map<String, List<Map<String, dynamic>>> roomMessages = {};

  @override
  void initState() {
    super.initState();
    GetUser().execute(widget.username).then((result) {
      setState(() {
        roomList = result.cast<String>();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: FutureBuilder<List>(
            future: GetChatRoom().execute(widget.username),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var chatList = snapshot.data!;
                return ListView(
                  children: List.generate(chatList.length, (i) {
                    var lastMessage = Helper().getLastMessage(chatList, i);
                    var otherUser = Helper()
                        .getOtherUser(chatList[i]['users'], widget.username);
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    roomId: roomList[i],
                                    username: widget.username,
                                    otherUser: otherUser,
                                  )));
                        },
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            '${chatList[i]['users'][1]}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(Helper().getLastMessageText(chatList, i)),
                          trailing: Text('${lastMessage['timestamp']}'),
                        ));
                  }),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Text('Belum ada chat');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Chat baru',
        child: const Icon(Icons.add),
      ),
    );
  }
}

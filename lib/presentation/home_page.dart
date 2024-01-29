import 'package:chatting_app_flutter/domain/entities/chat.dart';
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
  late List<String> roomList = [];
  late List<ChatData> chatList = [];

  @override
  void initState() {
    super.initState();
    GetUser().execute(widget.username).then((result) {
      setState(() {
        roomList = result.rooms;
      });
    });
    GetChatRoom().execute(widget.username).then((result) {
      setState(() {
        chatList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: FutureBuilder<List<ChatData>>(
              future: GetChatRoom().execute(widget.username),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text('Tidak ada chat'),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada chat'),
                  );
                } else {
                  var chatList = snapshot.data!;
                  return ListView(
                    children: List.generate(chatList.length, (i) {
                      var lastMessage = Helper().getLastMessage(chatList, i);
                      var otherUser = Helper()
                          .getOtherUser(chatList[i].users, widget.username);
                      var formattedDate =
                          Helper().formatDateTime(lastMessage['timestamp']);
                      return InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      roomId: roomList[i],
                                      username: widget.username,
                                      otherUser: otherUser,
                                    )));
                            GetChatRoom()
                                .execute(widget.username)
                                .then((result) {
                              setState(() {
                                chatList = result;
                              });
                            });
                          },
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              otherUser,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(lastMessage['message']
                                        .toString()
                                        .length >
                                    30
                                ? '${lastMessage['message'].toString().substring(0, 20)}...'
                                : lastMessage['message'].toString()),
                            trailing: Text(formattedDate),
                          ));
                    }),
                  );
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? to = await showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                TextEditingController usernameController =
                    TextEditingController();
                return AlertDialog(
                  title: const Text('Buat chat baru'),
                  content: TextField(
                    controller: usernameController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Tujuan chat',
                      hintText: 'Masukkan username tujuan chat',
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(usernameController.text);
                      },
                    ),
                  ],
                );
              },
            );
            // if (to != null && to.isNotEmpty) {
            // var from = widget.username;
            // var room = await CreateChatRoom().execute(from, to);
            // }
          },
          tooltip: 'Chat baru',
          child: const Icon(Icons.add),
        ));
  }
}

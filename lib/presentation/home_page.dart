import 'package:chatting_app_flutter/domain/usecases/get_chat_room.dart';
import 'package:chatting_app_flutter/domain/usecases/get_user.dart';
import 'package:chatting_app_flutter/presentation/chat_page.dart';
import 'package:chatting_app_flutter/presentation/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listChat = [];
  Map<String, List<Map<String, dynamic>>> roomMessages = {};

  @override
  void initState() {
    super.initState();
    GetUser().execute(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: FutureBuilder<List>(
            future: GetChatRoom().execute(widget.username),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var listChat = snapshot.data!;
                return ListView(
                  children: List.generate(listChat.length, (i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage()));
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Text(
                              '${listChat[i]['users'][1]}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '${listChat[i]['messages'][listChat[i]['messages'].length - 1]['text']}')
                          ],
                        ),
                      ),
                    );
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

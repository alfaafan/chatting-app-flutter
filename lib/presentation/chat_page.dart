import 'package:chatting_app_flutter/domain/entities/chat_room.dart';
import 'package:chatting_app_flutter/domain/entities/message_send.dart';
import 'package:chatting_app_flutter/domain/usecases/create_message.dart';
import 'package:chatting_app_flutter/domain/usecases/get_chat.dart';
import 'package:chatting_app_flutter/presentation/common/common_app_bar.dart';
import 'package:chatting_app_flutter/shared/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.roomId,
      required this.username,
      required this.otherUser});

  final String roomId;
  final String username;
  final String otherUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late Future<ChatRoom> chatRoomData;

  @override
  void initState() {
    super.initState();
    chatRoomData = GetChat().execute(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          title: Text(
            widget.otherUser,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<ChatRoom>(
                future: GetChat().execute(widget.roomId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    var messages = snapshot.data!.messages;
                    String currentUser = widget.username;

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, i) {
                        bool isCurrentUser =
                            messages[i].username == currentUser;

                        var formattedDate =
                            Helper().formatDateTime(messages[i].timestamp);

                        return Align(
                            alignment: isCurrentUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                                constraints:
                                    const BoxConstraints(minWidth: 100),
                                padding: const EdgeInsets.all(7.5),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: isCurrentUser
                                        ? Colors.orangeAccent
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(messages[i].text),
                                    Text(
                                      formattedDate,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 10,
                                          color: Colors.black54),
                                    )
                                  ],
                                )));
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Masukkan pesan anda'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          print(widget.username);
                          MessageSend message = MessageSend(
                              id: widget.roomId,
                              username: widget.username,
                              text: _messageController.text);
                          await CreateMessage().execute(message);

                          setState(() {
                            _messageController.clear();
                            chatRoomData = GetChat().execute(widget.roomId);
                          });
                        },
                        child: const Icon(Icons.send)),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

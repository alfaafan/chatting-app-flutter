import 'package:chatting_app_flutter/domain/usecases/get_chat.dart';
import 'package:chatting_app_flutter/presentation/common/common_app_bar.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.roomId, required this.username});

  final String roomId;
  final String username;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: GetChat().execute(widget.roomId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            var data = snapshot.data!;
            return const Center(
              child: Column(
                children: [],
              ),
            );
          }
        },
      ),
    );
  }
}

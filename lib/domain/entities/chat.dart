import 'package:chatting_app_flutter/domain/entities/message.dart';

class ChatData {
  List<String> users;
  List<Message> messages;

  ChatData({required this.users, required this.messages});

  factory ChatData.fromJson(Map<String, dynamic> json) {
    List<Message> messageList = [];
    for (var messageJson in json['messages']) {
      messageList.add(Message.fromJson(messageJson));
    }
    return ChatData(
        users: List<String>.from(json['users']), messages: messageList);
  }
}

import 'package:chatting_app_flutter/domain/entities/message.dart';

class ChatRoom {
  final List<String> users;
  final List<Message> messages;

  ChatRoom({required this.users, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      users: List<String>.from(json['users']),
      messages: List<Message>.from(
          json['messages'].map((message) => Message.fromJson(message))),
    );
  }
}

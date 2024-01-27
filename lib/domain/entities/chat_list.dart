import 'package:chatting_app_flutter/domain/entities/chat.dart';

class ChatList {
  List<ChatData> data;

  ChatList({required this.data});

  static List<ChatData> fromJson(Map<String, dynamic> json) {
    List<ChatData> chatDataList = [];
    for (var chatDataJson in json['data']) {
      chatDataList.add(ChatData.fromJson(chatDataJson));
    }
    return chatDataList;
  }
}

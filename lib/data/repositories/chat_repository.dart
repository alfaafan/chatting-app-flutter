import 'dart:async';
import 'dart:convert';

import 'package:chatting_app_flutter/data/datasources/remote_chat_datasource.dart';
import 'package:chatting_app_flutter/domain/entities/chat.dart';
import 'package:chatting_app_flutter/domain/entities/chat_list.dart';
import 'package:chatting_app_flutter/domain/entities/chat_room.dart';
import 'package:chatting_app_flutter/domain/entities/message_send.dart';
import 'package:chatting_app_flutter/domain/entities/user.dart';

class ChatRepository {
  var remoteChatDatasource = RemoteChatDatasource();

  Future<User> getUser(String username) async {
    var response =
        jsonDecode(await remoteChatDatasource.getUser(username))['data'];
    User user = User.fromJson(response);

    return user;
  }

  Future<List<ChatData>> getRooms(String username) async {
    var listChatRoom = jsonDecode(await remoteChatDatasource.getRoom(username));
    List<ChatData> chatList = ChatList.fromJson(listChatRoom);
    return chatList;
  }

  Future<ChatRoom> getChat(String id) async {
    try {
      var response = jsonDecode(await remoteChatDatasource.getChat(id))['data'];

      ChatRoom chatRoom = ChatRoom.fromJson(response);

      return chatRoom;
    } catch (e) {
      throw Exception('Failed to fetch chat: $e');
    }
  }

  Future<Map<String, dynamic>> createRoom(String from, String to) async {
    var response =
        jsonDecode(await remoteChatDatasource.createRoom(from, to))['data'];
    return response;
  }

  Future<bool> createChat(MessageSend message) async {
    print(message.runtimeType);
    var response =
        await remoteChatDatasource.createChat(message.toJson() as MessageSend);
    print(response);
    return response == 'true' ? true : false;
  }
}

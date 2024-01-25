import 'dart:convert';

import 'package:chatting_app_flutter/data/datasources/remote_chat_datasource.dart';

class ChatRepository {
  var remoteChatDatasource = RemoteChatDatasource();

  Future<List> getUser(String username) async {
    var jsonArray =
        jsonDecode(await remoteChatDatasource.getUser(username))['data'];
    var listChat = jsonArray['rooms'];

    return listChat;
  }

  Future<List> getRooms(String username) async {
    var listChatRoom =
        jsonDecode(await remoteChatDatasource.getRoom(username))['data'];
    return listChatRoom;
  }

  Future<Map<String, dynamic>> getChat(String id) async {
    var chat = jsonDecode(await remoteChatDatasource.getChat(id))['data'];

    return chat;
  }

  Future<String> createRoom(String from, String to) async {
    var response = await remoteChatDatasource.createRoom(from, to);
    return response;
  }

  Future<String> createChat(String id, String from, String text) async {
    var response = await remoteChatDatasource.createChat(id, from, text);
    return response;
  }
}

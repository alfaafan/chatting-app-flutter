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
    print(listChatRoom[0]);
    return listChatRoom;
  }
}

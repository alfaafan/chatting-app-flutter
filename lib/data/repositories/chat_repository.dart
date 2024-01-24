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
}

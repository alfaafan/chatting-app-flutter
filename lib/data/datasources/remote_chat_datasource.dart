import 'dart:convert';

import 'package:chatting_app_flutter/domain/entities/message_send.dart';
import 'package:http/http.dart' as http;

class RemoteChatDatasource {
  static const url = 'http://127.0.0.1:8080';

  Future<String> getUser(String username) async {
    var response = await http.get(Uri.parse('$url/api/user/$username'));
    return response.body;
  }

  Future<String> getChat(String id) async {
    var response = await http.get(Uri.parse('$url/api/chat/$id'));
    return response.body;
  }

  Future<String> getRoom(String username) async {
    var response = await http.get(Uri.parse('$url/api/room/$username'));
    return response.body;
  }

  Future<String> createRoom(String from, String to) async {
    var response = await http.post(Uri.parse('$url/api/room'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'from': from, 'to': to}));
    return response.body;
  }

  Future<String> createChat(MessageSend message) async {
    print(message.text);
    var response = await http.post(Uri.parse('$url/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': message.id,
          'username': message.username,
          'text': message.text,
        }));
    return response.body;
  }
}

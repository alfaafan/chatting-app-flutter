import 'dart:convert';

import 'package:chatting_app_flutter/domain/entities/message_send.dart';
import 'package:http/http.dart' as http;

class RemoteChatDatasource {
  static const url = 'http://127.0.0.1:8080';

  Future<String> getUser(String username) async {
    var response = await http.get(Uri.parse('$url/api/user/$username'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get user data');
    }
  }

  Future<String> getChat(String id) async {
    var response = await http.get(Uri.parse('$url/api/chat/$id'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get user chat');
    }
  }

  Future<String> getRoom(String username) async {
    var response = await http.get(Uri.parse('$url/api/room/$username'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get user room');
    }
  }

  Future<String> createRoom(String from, String to) async {
    var response = await http.post(Uri.parse('$url/api/room'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'from': from, 'to': to}));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post user room');
    }
  }

  Future<String> createChat(MessageSend message) async {
    print({
      'id': message.id,
      'from': message.username,
      'text': message.text,
    });
    var response = await http.post(Uri.parse('$url/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': message.id,
          'from': message.username,
          'text': message.text,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post user chat');
    }
  }
}

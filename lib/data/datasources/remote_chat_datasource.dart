import 'dart:convert';

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

  Future<String> createChat(String id, String from, String text) async {
    var response = await http.post(Uri.parse('$url/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'id': id, 'from': from, 'text': text}));
    return response.body;
  }
}

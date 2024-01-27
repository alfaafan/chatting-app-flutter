import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';

class CreateChatRoom {
  var repository = ChatRepository();

  Future<Map<String, dynamic>> execute(String from, String to) {
    return repository.createRoom(from, to);
  }
}

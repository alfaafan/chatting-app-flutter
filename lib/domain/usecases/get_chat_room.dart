import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';

class GetChatRoom {
  var repository = ChatRepository();

  Future<List> execute(username) {
    return repository.getRooms(username);
  }
}

import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';

class GetUser {
  var repository = ChatRepository();

  Future<List> execute(username) {
    return repository.getUser(username);
  }
}

import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';
import 'package:chatting_app_flutter/domain/entities/user.dart';

class GetUser {
  var repository = ChatRepository();

  Future<User> execute(username) {
    return repository.getUser(username);
  }
}

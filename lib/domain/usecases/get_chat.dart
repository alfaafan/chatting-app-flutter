import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';

class GetChat {
  var repository = ChatRepository();

  Future<Map<String, dynamic>> execute(id) {
    return repository.getChat(id);
  }
}

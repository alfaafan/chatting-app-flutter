import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';
import 'package:chatting_app_flutter/domain/entities/chat_room.dart';

class GetChat {
  var repository = ChatRepository();

  Future<ChatRoom> execute(String id) {
    return repository.getChat(id);
  }
}

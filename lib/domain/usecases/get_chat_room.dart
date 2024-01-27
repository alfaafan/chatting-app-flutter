import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';
import 'package:chatting_app_flutter/domain/entities/chat.dart';

class GetChatRoom {
  var repository = ChatRepository();

  Future<List<ChatData>> execute(username) {
    return repository.getRooms(username);
  }
}

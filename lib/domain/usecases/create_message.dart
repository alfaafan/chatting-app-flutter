import 'package:chatting_app_flutter/data/repositories/chat_repository.dart';
import 'package:chatting_app_flutter/domain/entities/message_send.dart';

class CreateMessage {
  var repository = ChatRepository();

  Future<bool> execute(MessageSend message) {
    return repository.createChat(message);
  }
}

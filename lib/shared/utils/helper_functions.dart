import 'package:chatting_app_flutter/domain/entities/chat.dart';
import 'package:intl/intl.dart';

class Helper {
  String getLastMessageText(List listChat, int i) {
    if (listChat.length > i &&
        listChat[i]['messages'] is List &&
        listChat[i]['messages'].isNotEmpty &&
        listChat[i]['messages'].last['text'] != null) {
      return listChat[i]['messages'].last['text'].toString();
    } else {
      return 'Tidak ada pesan';
    }
  }

  Map<String, dynamic> getLastMessage(List<ChatData> chatList, int i) {
    if (chatList.length > i && chatList[i].messages.isNotEmpty) {
      return {
        'message': chatList[i].messages.last.text.toString(),
        'timestamp': chatList[i].messages.last.timestamp,
      };
    } else {
      return {
        'message': 'Tidak ada pesan',
        'timestamp': null,
      };
    }
  }

  String getOtherUser(List<dynamic> users, String currentUser) {
    return users.firstWhere((user) => user != currentUser);
  }

  String formatDateTime(var time) {
    int timestamp = int.parse(time);
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('HH:mm');
    return formatter.format(date);
  }
}

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
}

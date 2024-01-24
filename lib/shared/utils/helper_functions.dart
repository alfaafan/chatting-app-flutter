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

  // List<String> getFilteredUsernames(List<dynamic> dataList, String myUsername) {
  //   for (var data in dataList) {
  //     if (data['users'] is List && data['users'].contains(myUsername)) {
  //       List<String> users = List<String>.from(data['users']);
  //       users.remove(myUsername);
  //     }
  //   }

  //   return users;
  // }
}

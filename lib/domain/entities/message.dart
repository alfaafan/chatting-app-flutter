class Message {
  String username;
  String text;
  var timestamp;

  Message({
    required this.username,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        text: json['text'],
        username: json['username'],
        timestamp: json['timestamp']);
  }
}

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
    print({
      'debug': 'Message.fromJson',
      'username': {
        'username': json['username'],
        'type': json['username'].runtimeType
      },
      'text': {'text': json['text'], 'type': json['text'].runtimeType},
      'timestamp': {
        'timestamp': json['timestamp'].toString(),
        'type': json['timestamp'].runtimeType,
        'formatted':
            DateTime.fromMillisecondsSinceEpoch(int.parse(json['timestamp']))
                .toString()
      },
    });

    return Message(
        username: json['username'],
        text: json['text'] as String,
        timestamp: json['timestamp'].toString());
  }
}

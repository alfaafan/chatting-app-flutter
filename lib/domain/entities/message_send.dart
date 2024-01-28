// ignore_for_file: unnecessary_this

class MessageSend {
  String id;
  String username;
  String text;

  MessageSend({
    required this.id,
    required this.username,
    required this.text,
  });

  factory MessageSend.fromJson(Map<String, dynamic> json) {
    return MessageSend(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    print({
      'debug': 'MessageSend.toJson',
      'id': {'id': this.id, 'type': this.id.runtimeType},
      'username': {
        'username': this.username,
        'type': this.username.runtimeType
      },
      'text': {'text': this.text, 'type': this.text.runtimeType},
    });
    return {
      'id': this.id,
      'username': this.username,
      'text': this.text,
    };
  }
}

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
    return {
      'id': this.id,
      'username': this.username,
      'text': this.text,
    };
  }
}

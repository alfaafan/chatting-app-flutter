class User {
  List<String> rooms;

  User({required this.rooms});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      rooms: List<String>.from(json['rooms']),
    );
  }
}

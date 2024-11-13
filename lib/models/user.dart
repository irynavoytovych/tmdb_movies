class User {
  final int id;
  final String username;

  User({
    required this.id,
    required this.username,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }
}

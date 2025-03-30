class User {
  String username;
  String token;

  User({
    required this.username,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: setUsername(json),
      token: setToken(json),
    );
  }

  User copyWith({
    String? username,
    String? token,
  }) =>
      User(
        username: username ?? this.username,
        token: token ?? this.token,
      );

  static User defaultValues() => User(
        username: '',
        token: '',
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'token': token,
      };

  static String setUsername(Map<String, dynamic> json) {
    if (json.containsKey('username')) {
      if (json['username'] != null &&
          json['username'] is String &&
          json['username'].toString().isNotEmpty) {
        return json['username'];
      }
    }

    return '';
  }

  static String setToken(Map<String, dynamic> json) {
    if (json.containsKey('token')) {
      if (json['token'] != null &&
          json['token'] is String &&
          json['token'].toString().isNotEmpty) {
        return json['token'];
      }
    }

    return '';
  }
}

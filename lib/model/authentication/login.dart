class Login {
  String username;
  String password;

  Login({
    required this.username,
    required this.password,
  });

  Login copyWith({
    String? username,
    String? password,
  }) =>
      Login(
        username: username ?? this.username,
        password: password ?? this.password,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

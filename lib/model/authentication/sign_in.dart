class SignIn {
  String username;
  String password;

  SignIn({required this.username, required this.password});

  SignIn copyWith({String? username, String? password}) => SignIn(
    username: username ?? this.username,
    password: password ?? this.password,
  );

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

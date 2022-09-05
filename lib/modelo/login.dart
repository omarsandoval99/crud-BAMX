import 'dart:convert';

class Login {
  String correo;
  String password;

  Login({required this.correo, required this.password});

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        correo: (json["correo"]),
        password: (json["password"].toString()),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() =>
      {"email": correo, "password": password, "returnSecureToken": true};
}

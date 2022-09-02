class Login {
  String correo;
  String password;

  Login({required this.correo, required this.password});

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        correo: (json["correo"]),
        password: (json["clave"].toString()),
      );
}

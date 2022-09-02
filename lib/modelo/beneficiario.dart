import 'dart:convert';

class Beneficiarios {
  String nombre;
  String telefono;
  String? id;
  Beneficiarios({
    required this.nombre,
    required this.telefono,
  });

  factory Beneficiarios.fromJson(String str) =>
      Beneficiarios.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Beneficiarios.fromMap(Map<String, dynamic> json) => Beneficiarios(
        nombre: (json["nombre"]),
        telefono: (json["telefono"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "telefono": telefono,
      };
}

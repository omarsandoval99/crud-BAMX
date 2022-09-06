import 'dart:convert';

class User {
  User({
    required this.kind,
    required this.localId,
    required this.email,
    required this.displayName,
    required this.idToken,
    required this.registered,
  });

  String kind;
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        kind: (json["kind"]),
        localId: (json["localId"]),
        email: (json["email"]),
        displayName: (json["displayName"]),
        idToken: (json["idToken"]),
        registered: (json["registered"]),
      );

  Map<String, dynamic> toMap() => {
        "kind": kind,
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "idToken": idToken,
        "registered": registered,
      };
}

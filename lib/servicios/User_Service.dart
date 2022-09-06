import 'dart:convert';

import 'package:crud/imports.dart';
import 'package:crud/modelo/login.dart';
import 'package:crud/modelo/user.dart';
import 'package:crud/servicios/login_form_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Servicio_Users extends ChangeNotifier {
  List<User> UsuarioLogeado = [];
  late Login listlogin;

  Servicio_usuario(String email, String password) {
    metodoUser(email, password);
  }

  Future metodoUser(String email, String password) async {
    listlogin = Login(correo: email, password: password);

    final String _UrlBase = 'identitytoolkit.googleapis.com';
    final url = Uri.https(_UrlBase, '/v1/accounts:signInWithPassword',
        {'key': 'AIzaSyBrdAiVXKnSyBLiRPZgMX7B4tly8TBqVqc'});
    print(url);

    final resp = await http.post(url, body: listlogin.toJson());

    print(resp.body);

    final Map<String, dynamic> list = jsonDecode(resp.body);

    final listausuario = User.fromMap(list);

    UsuarioLogeado.add(listausuario);
    notifyListeners();
    return UsuarioLogeado;
  }
}

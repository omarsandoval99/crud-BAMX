import 'package:crud/imports.dart';
import 'package:crud/modelo/login.dart';
import 'package:crud/modelo/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Serv_Beneficiarios extends ChangeNotifier {
  final String _UrlBase = 'crudbamx-default-rtdb.firebaseio.com';

  List<Beneficiarios> Listabeneficiarios = [];
  List<User> UsuarioLogeado = [];

  String UserId = "";
  Serv_Beneficiarios(String id) {
    UserId = id;
  }

  Future MetodoGet() async {
    final url =
        Uri.https(_UrlBase, 'beneficiarios/${UsuarioLogeado[0].localId}.json');
    final respuesta = await http.get(url);
    final Map<String, dynamic> list = jsonDecode(respuesta.body);

    list.forEach((String key, value) {
      final beneficiario = Beneficiarios.fromMap(value);
      beneficiario.id = key;

      Listabeneficiarios.add(beneficiario);
    });

    notifyListeners();
    return Listabeneficiarios;
  }

  Future MetodoPatch(Beneficiarios beneficiario) async {
    final url = Uri.https(_UrlBase,
        'beneficiarios/${UsuarioLogeado[0].localId}/${beneficiario.id}.json');

    final resp = await http.patch(url, body: beneficiario.toJson());
    final respuesta = resp.body;

    final index = Listabeneficiarios.indexWhere(
        (element) => element.id == beneficiario.id);

    Listabeneficiarios[index] = beneficiario;

    notifyListeners();
  }

  Future MetodoPost(Beneficiarios beneficiario) async {
    final url =
        Uri.https(_UrlBase, 'beneficiarios/${UsuarioLogeado[0].localId}.json');

    final resp = await http.post(url, body: beneficiario.toJson());
    final respuesta = json.decode(resp.body);

    beneficiario.id = respuesta["name"];
    Listabeneficiarios.add(beneficiario);
    notifyListeners();
  }

  Future MetodoDelete(Beneficiarios beneficiario) async {
    final url = Uri.https(_UrlBase,
        'beneficiarios/${UsuarioLogeado[0].localId}/${beneficiario.id}.json');

    final resp = await http.delete(url, body: beneficiario.toJson());

    final index = Listabeneficiarios.indexWhere(
        (element) => element.id == beneficiario.id);

    Listabeneficiarios.removeAt(index);

    notifyListeners();
  }

  Future metodoUser(String email, String password) async {
    Login listlogin = Login(correo: email, password: password);

    final String _UrlBase = 'identitytoolkit.googleapis.com';
    final url = Uri.https(_UrlBase, '/v1/accounts:signInWithPassword',
        {'key': 'AIzaSyBrdAiVXKnSyBLiRPZgMX7B4tly8TBqVqc'});
    print(url);

    final resp = await http.post(url, body: listlogin.toJson());

    final Map<String, dynamic> list = jsonDecode(resp.body);

    list.forEach((String key, value) {
      if ((key.compareTo("error")) == 0) {
        print("error");
        notifyListeners();
        return;
      } else {
        final usuario = User.fromMap(list);

        UsuarioLogeado.add(usuario);
      }
    });
    MetodoGet();
    notifyListeners();
    return UsuarioLogeado;
  }
}

import 'package:crud/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Serv_Beneficiarios extends ChangeNotifier {
  final String _UrlBase = 'crudbamx-default-rtdb.firebaseio.com';
  List<Beneficiarios> Listabeneficiarios = [];

  Serv_Beneficiarios() {
    MetodoGet();
  }

  Future MetodoGet() async {
    final url = Uri.https(_UrlBase, 'beneficiarios.json');
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
    final url = Uri.https(_UrlBase, 'beneficiarios/${beneficiario.id}.json');

    final resp = await http.patch(url, body: beneficiario.toJson());
    final respuesta = resp.body;

    final index = Listabeneficiarios.indexWhere(
        (element) => element.id == beneficiario.id);

    Listabeneficiarios[index] = beneficiario;

    notifyListeners();
  }

  Future MetodoPost(Beneficiarios beneficiario) async {
    final url = Uri.https(_UrlBase, 'beneficiarios.json');

    final resp = await http.post(url, body: beneficiario.toJson());
    final respuesta = json.decode(resp.body);

    beneficiario.id = respuesta["name"];
    Listabeneficiarios.add(beneficiario);
    notifyListeners();
  }

  Future MetodoDelete(Beneficiarios beneficiario) async {
    final url = Uri.https(_UrlBase, 'beneficiarios/${beneficiario.id}.json');

    final resp = await http.delete(url, body: beneficiario.toJson());

    final index = Listabeneficiarios.indexWhere(
        (element) => element.id == beneficiario.id);

    Listabeneficiarios.removeAt(index);

    notifyListeners();
  }
}

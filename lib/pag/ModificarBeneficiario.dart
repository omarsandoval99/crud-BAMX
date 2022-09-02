import 'dart:convert';

import 'package:crud/imports.dart';

class ModificarBeneficiario extends StatefulWidget {
  final Beneficiarios _cliente;
  ModificarBeneficiario(this._cliente);

  @override
  State<ModificarBeneficiario> createState() => _ModificarBeneficiarioState();
}

class _ModificarBeneficiarioState extends State<ModificarBeneficiario> {
  late TextEditingController controladorNombre;
  late TextEditingController controladortelefono;
  @override
  void initState() {
    Beneficiarios c = widget._cliente;
    controladorNombre = new TextEditingController(text: c.nombre);
    controladortelefono = new TextEditingController(text: c.telefono);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            controller: controladorNombre,
            decoration: InputDecoration(
                filled: true,
                labelText: "Nombre",
                suffix: GestureDetector(
                  child: Icon(Icons.close),
                  onTap: () {
                    controladorNombre.clear();
                  },
                )),
          ),
          TextField(
            controller: controladortelefono,
            decoration: InputDecoration(
                filled: true,
                labelText: "Telefono",
                suffix: GestureDetector(
                  child: Icon(Icons.close),
                  onTap: () {
                    controladorNombre.clear();
                  },
                )),
          ),
          ElevatedButton(
            onPressed: () {
              String nom = controladorNombre.text;
              String tel = controladortelefono.text;

              Beneficiarios c = Beneficiarios(nombre: nom, telefono: tel);
              c.id = widget._cliente.id;
              if (nom.isNotEmpty && tel.isNotEmpty) {
                Navigator.pop(context, c);
              }
            },
            child: Text("Guardar Contacto"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text("Borrar"))
        ],
      ),
    );
  }
}

import 'package:crud/imports.dart';

class RegistrarBeneficiario extends StatefulWidget {
  @override
  State<RegistrarBeneficiario> createState() => _RegistrarBeneficiario();
}

class _RegistrarBeneficiario extends State<RegistrarBeneficiario> {
  late TextEditingController controladorNombre;
  late TextEditingController controladortelefono;
  @override
  void initState() {
    controladorNombre = new TextEditingController();
    controladortelefono = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Beneficiario'),
      ),
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
                  child: const Icon(Icons.close),
                  onTap: () {
                    controladorNombre.clear();
                  },
                )),
          ),
          ElevatedButton(
              onPressed: () {
                String nom = controladorNombre.text;
                String tel = controladortelefono.text;

                if (nom.isNotEmpty && tel.isNotEmpty) {
                  Navigator.pop(
                      //tiene que cambiar el id por uno generico
                      context,
                      Beneficiarios(nombre: nom, telefono: tel));
                }
              },
              child: const Text("Guardar Contacto")),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:crud/provider/provider.dart';
import 'package:crud/imports.dart';
import 'package:crud/modelo/user.dart';
import 'package:crud/servicios/servicios_beneficiarios.dart';
import 'package:provider/provider.dart';

bool eliminarVerdadero = false;

class PantallaPrincipal extends StatefulWidget {
  final String _titulo;
  const PantallaPrincipal(this._titulo);

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    final ServBeneficiario = Provider.of<Serv_Beneficiarios>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget._titulo),
      ),
      body: ListView.builder(
        itemCount: ServBeneficiario.Listabeneficiarios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ServBeneficiario.Listabeneficiarios[index].nombre),
            subtitle: Text(ServBeneficiario.Listabeneficiarios[index].telefono),
            leading: CircleAvatar(
              child: Text(ServBeneficiario.Listabeneficiarios[index].nombre
                  .substring(0, 1)),
              backgroundColor: Colors.deepPurple,
            ),
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ModificarBeneficiario(
                              ServBeneficiario.Listabeneficiarios[index])))
                  .then((modificado) {
                if (modificado != null) {
                  setState(() {
                    ServBeneficiario.MetodoPatch(modificado);
                  });
                } else {
                  ServBeneficiario.MetodoDelete(
                      ServBeneficiario.Listabeneficiarios[index]);
                }
              });
            },
            onLongPress: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RegistrarBeneficiario()))
              .then((NuevoBeneficiario) {
            if (NuevoBeneficiario != null) {
              setState(() {
                ServBeneficiario.MetodoPost(NuevoBeneficiario);
              });
            }
          });
        },
        backgroundColor: Color.fromARGB(255, 76, 102, 175),
        child: const Icon(Icons.add),
      ),
    );
  }
}

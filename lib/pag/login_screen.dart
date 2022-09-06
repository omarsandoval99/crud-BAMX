import 'package:crud/imports.dart';
import 'package:crud/modelo/user.dart';
import 'package:crud/servicios/login_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:crud/widgets/widgets.dart';
import 'package:crud/ui/input_decorations.dart';
import 'package:crud/servicios/User_Service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text('Login', style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForm())
            ],
          )),
          const SizedBox(height: 50),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'example@example.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: const TextStyle(color: Colors.white),
                  )),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      await Future.delayed(const Duration(seconds: 2));

                      // TODO: validar si el login es correcto
                      final ServBeneficiario = Provider.of<Serv_Beneficiarios>(
                          context,
                          listen: false);

                      ServBeneficiario.metodoUser(
                              loginForm.email, loginForm.password)
                          .then((value) => {
                                if (ServBeneficiario.UsuarioLogeado.isEmpty)
                                  {Alerta(context)}
                                else
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const PantallaPrincipal(
                                                    "Beneficiarios")))
                                  }
                              });

                      loginForm.isLoading = false;
                    })
        ],
      ),
    );
  }

  Alerta(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              title: Text("Alerta"),
              content: Text("Datos incorrectos"),
            ));
  }
}


  /*        
                      List<Login> ListaLogin = [];
                      final String _UrlBase =
                          'crudbamx-default-rtdb.firebaseio.com';
                      final url = Uri.https(_UrlBase, 'login.json');
                      final respuesta = await http.get(url);
                      final Map<String, dynamic> list =
                          jsonDecode(respuesta.body);

                      list.forEach((key, value) {
                        final login = Login.fromMap(value);

                        ListaLogin.add(login);
                      });
                      bool encontrado = false;

                      for (var i = 0; i < ListaLogin.length; i++) {
                        int Vcorreo =
                            ListaLogin[i].correo.compareTo(loginForm.email);
                        int Vpassword = ListaLogin[i]
                            .password
                            .compareTo(loginForm.password);
                        if ((Vcorreo == 0) && (Vpassword == 0)) {
                          encontrado = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AppState()));
                        }
                      }

                      if (!encontrado) {
                        Alerta(context);
                      }
*/
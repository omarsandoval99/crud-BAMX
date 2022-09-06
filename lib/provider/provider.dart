import 'package:crud/imports.dart';
import 'package:crud/main.dart';
import 'package:crud/pag/login_screen.dart';
import 'package:provider/provider.dart';

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Serv_Beneficiarios(""))
      ],
      child: const MyApp(),
    );
  }
}

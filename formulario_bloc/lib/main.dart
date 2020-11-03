import 'package:flutter/material.dart';
import 'package:formulario_bloc/src/pages/home_page.dart';
import 'package:formulario_bloc/src/pages/registro_page.dart';
import 'package:formulario_bloc/src/pages/login_page.dart';
import 'package:formulario_bloc/src/pages/producto_page.dart';
import 'package:formulario_bloc/src/preferencias_usuario/preferencias_usuario.dart';

import 'src/bloc/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'registro',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'registro': (BuildContext context) => RegistroPage()
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

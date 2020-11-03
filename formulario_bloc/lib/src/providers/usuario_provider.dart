import 'dart:convert';
import 'package:formulario_bloc/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyA1u2PpcaiZnuTY0Bhyqp_vqd2QgDB9mgM';
  final _prefs = new PreferenciasUsuario();
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData),
    );
    //Recepcion de los datos
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    //Ver que se recibe
    print(decodedResp);
    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  //URL para llamar el registro y login de firebase
  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData),
    );
    //Recepcion de los datos
    Map<String, dynamic> decodedResp = json.decode(resp.body);

    //Ver que se recibe
    print(decodedResp);
    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}

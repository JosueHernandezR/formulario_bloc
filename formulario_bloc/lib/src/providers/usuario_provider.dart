import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyA1u2PpcaiZnuTY0Bhyqp_vqd2QgDB9mgM';

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
    Map<String, dynamic> decodeResp = json.decode(resp.body);

    //Ver que se recibe
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      //TODO: Salvar el token en el storage
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['error']['message']};
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
    Map<String, dynamic> decodeResp = json.decode(resp.body);

    //Ver que se recibe
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      //TODO: Salvar el token en el storage
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodeResp['error']['message']};
    }
  }
}

//Interacciones directas con la base de datos
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:formulario_bloc/src/models/model.dart';

class ProductosProvider {
  //Peticiones HTTP
  final String _url = 'https://flutter-varios-b582f.firebaseio.com';
  //CRUD

  Future<bool> crearProducto(ProductModel producto) async {
    final url = '$_url/productos.json';
    final resp = await http.post(url, body: productModelToJson(producto));

    //Verificar respuesta positiva o negativa
    final decodeData = json.decode(resp.body);

    //Prueba
    print(decodeData);
    return true;
  }
}

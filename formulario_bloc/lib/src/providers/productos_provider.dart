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

  Future<List<ProductModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    //Contiene otro tipo de informacion, estado, respuestas etc.
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductModel> productos = new List();
    if (decodedData == null) return [];
    //Prueba
    print(decodedData);

    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    print(productos);
    return productos;
  }
}

//Interacciones directas con la base de datos
import 'dart:convert';
import 'dart:io';
import 'package:formulario_bloc/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:formulario_bloc/src/models/model.dart';
import 'package:mime_type/mime_type.dart';

class ProductosProvider {
  //Peticiones HTTP
  final String _url = 'https://flutter-varios-b582f.firebaseio.com';
  //CRUD
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductModel producto) async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final resp = await http.post(url, body: productModelToJson(producto));

    //Verificar respuesta positiva o negativa
    final decodeData = json.decode(resp.body);

    //Prueba
    print(decodeData);
    return true;
  }

  Future<bool> editarProducto(ProductModel producto) async {
    final url = '$_url/productos/${producto.id}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: productModelToJson(producto));

    //Verificar respuesta positiva o negativa
    final decodeData = json.decode(resp.body);

    //Prueba
    print(decodeData);
    return true;
  }

  Future<List<ProductModel>> cargarProductos() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
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

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }

  // Subiendo imagen a Cloudinary
  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dcslliymu/image/upload?upload_preset=bdnovblh');

    //Extraccion
    final mimeType = mime(imagen.path).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);
    //Enviando peticion
    final streamsResponse = await imageUploadRequest.send();
    //Respuesta recibida del backend
    final resp = await http.Response.fromStream(streamsResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Algo salió mal");
      print(resp.body);
      return null;
    }
    // Extraer el secure_url
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}

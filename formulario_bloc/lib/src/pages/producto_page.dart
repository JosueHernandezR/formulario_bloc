import 'package:flutter/material.dart';
import 'package:formulario_bloc/src/models/model.dart';
import 'package:formulario_bloc/src/providers/productos_provider.dart';
import 'package:formulario_bloc/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final productoProvider = new ProductosProvider();

  ProductModel producto = new ProductModel();
  //Cuando se crea el widget no se ha modificado nada
  //Se usará para evitar que se guarde muchas veces la información
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.photo_size_select_actual,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(context),
                _crearPrecio(context),
                _crearDisponible(context),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(BuildContext context) {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(BuildContext context) {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearDisponible(context) {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: (_guardando) ? null : _submit,
      icon: Icon(Icons.save),
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    //Se ejecuta despues de haber validado el formulario
    formKey.currentState.save();

    // print(producto.titulo);
    // print(producto.valor);
    // print(producto.disponible);
    setState(() {
      _guardando = true;
    });

    if (producto.id == null)
      productoProvider.crearProducto(producto);
    else {
      productoProvider.editarProducto(producto);
    }
    //setState(() {_guardando = false;});
    mostrarSnackbar('Registro guardado');

    //Al momento de tocar el boton, se regresa a la página principal
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(
        milliseconds: 1500,
      ),
    );

    //Se creó un nuevo key para que el snackbar se activara
    //con relación al Scaffold
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}

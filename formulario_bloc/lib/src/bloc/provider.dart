import 'package:flutter/material.dart';

import 'package:formulario_bloc/src/bloc/login_bloc.dart';
export 'package:formulario_bloc/src/bloc/login_bloc.dart';

import 'package:formulario_bloc/src/bloc/productos_bloc.dart';
export 'package:formulario_bloc/src/bloc/productos_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBloc();

  static Provider _instancia;
  //Determina usar una nueva instancia o reutiliza
  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(
        key: key,
        child: child,
      );
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);
  //Crear singlestone para que la primera vez reciba información
  // Y la segunda solo reutilice

  //Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  //Busca en el context o en hijos un Provider y de este extraer el loginBloc
  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._productosBloc;
  }
}

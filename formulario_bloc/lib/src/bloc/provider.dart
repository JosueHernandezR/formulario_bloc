import 'package:flutter/material.dart';
import 'package:formulario_bloc/src/bloc/login_bloc.dart';
export 'package:formulario_bloc/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
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

  final loginBloc = LoginBloc();

  //Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}

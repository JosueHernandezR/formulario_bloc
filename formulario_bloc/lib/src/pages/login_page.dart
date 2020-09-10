import 'package:flutter/material.dart';
import 'package:formulario_bloc/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ],
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.25,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
            padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size.height * 0.05),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 20.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
          Text('¿Olvidó la contraseña?'),
          SizedBox(
            height: size.height * 0.01,
          ),
        ],
      ),
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña',
                errorText: snapshot.error,
              ),
              onChanged: bloc.changePassword),
        );
      },
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'ejemplo@ejemplo.com',
              labelText: 'Correo electrónico',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final size = MediaQuery.of(context).size;
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.height * 0.08, vertical: size.width * 0.015),
            child: Text(
              'Ingresar',
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.height * 0.05),
          ),
          elevation: 0.0,
          textColor: Colors.white,
          color: Colors.deepPurple,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) {
    print('=====================');
    print('Email = ${bloc.email}');
    print('Email = ${bloc.password}');
    print('=====================');
    Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearFondo(context) {
    final size = MediaQuery.of(context).size;
    final fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        ),
      ),
    );
    final circulo = Container(
      width: size.height * 0.1,
      height: size.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.06)),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: size.height * 0.08),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: size.height * 0.015,
                width: double.infinity,
              ),
              Text(
                'Josue Hernandez',
                style: TextStyle(color: Colors.white, fontSize: 25),
              )
            ],
          ),
        )
      ],
    );
  }
}

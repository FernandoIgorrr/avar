import 'package:avar/routs/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadScreen extends StatefulWidget {
  LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  initState() {
    super.initState();
    verificarUsuario().then((value) => {
          if (value)
            print("asdasd")
          else
            Navigator.pushReplacementNamed(context, AppRoutes.loginScreen)
        });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Bem-vindo, LoadScreen'),
      ),
    );
  }

  Future<bool> verificarUsuario() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = _sharedPreferences.getString('token');

    if (token == null) return false;

    return true;
  }
}

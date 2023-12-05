import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:avar/core/app_export.dart';

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
            Navigator.pushNamed(context, AppRoutes.loginScreen)
          else
            Navigator.pushNamed(context, AppRoutes.loginScreen)
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

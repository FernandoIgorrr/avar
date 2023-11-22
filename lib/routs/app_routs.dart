import 'package:avar/presentation/patrimonios_home_page/cadastrar_patrimonio_page/cadastrar_patrimonio_page.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_page.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_tudo.dart';
import 'package:avar/presentation/patrimonios_home_page/patrimonios_home_page.dart';
import 'package:avar/presentation/supervisor_home_page/supervisor_home_page.dart';
import 'package:avar/presentation/load_screen/load_screen.dart';
import 'package:avar/presentation/login_screen/login_screen.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String loadScreen = '/load_screen';
  static const String supervisorHomePage = '/supervisor_home_page';
  static const String patrimoniosHomePage = '/patrimonios_home_page';
  static const String listarPatrimoniosHomePage =
      '/listar_patrimonios_home_page';
  static const String listarPatrimoniosTudo = 'listar_patrimonios_tudo';
  static const String cadastrarPatrimonio = 'cadastrar_patrimonio';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    loadScreen: (context) => LoadScreen(),
    supervisorHomePage: (context) => SupervisorHomePage(),
    patrimoniosHomePage: (context) => PatrimoniosHomePage(),
    listarPatrimoniosHomePage: (context) => ListarPatrimoniosPage(),
    listarPatrimoniosTudo: (context) => ListarPatrimoniosTudo(),
    cadastrarPatrimonio: (context) => CadastrarPatrimonioPage(),
  };
}

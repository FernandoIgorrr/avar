import 'package:avar/presentation/supervisor_home_page/supervisor_home_page.dart';
import 'package:avar/presentation/load_screen/load_screen.dart';
import 'package:avar/presentation/login_screen/login_screen.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String loadScreen = '/load_screen';
  static const String supervisorHomePage = '/supervisor_home_page';
  static const String supervisorHomeContainerScreen =
      '/supervisor_home_container_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    loadScreen: (context) => LoadScreen(),
    //supervisorHomeContainerScreen: (context) => SupervisorHomeContainerScreen(),
    supervisorHomePage: (context) => SupervisorHomePage(),
  };
}

import 'package:avar/presentation/load_screen/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:avar/presentation/login_screen/login_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String loadScreen = '/load_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    loadScreen: (context) => LoadScreen(),
  };
}

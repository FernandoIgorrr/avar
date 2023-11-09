import 'package:avar/core/app_export.dart';
import 'package:avar/routs/app_routs.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'avar',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorService.navigatorKey,
      //home: LoadScreen(),
      initialRoute: AppRoutes.loadScreen,
      routes: AppRoutes.routes,
    );
  }
}

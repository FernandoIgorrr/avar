import 'package:shared_preferences/shared_preferences.dart';

class Usuario {
  static Future<String?> recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

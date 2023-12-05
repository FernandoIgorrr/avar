import 'package:shared_preferences/shared_preferences.dart';

class Usuario {
  static Future<String?> recuperarToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }
}

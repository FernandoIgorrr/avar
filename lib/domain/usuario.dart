import 'package:avar/domain/connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario extends Connection {
  String? id;
  String? login;
  TipoUsuario? tipoUsuario;

  Usuario({this.id, this.login, this.tipoUsuario});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    tipoUsuario = json['tipoUsuario'] != null
        ? new TipoUsuario.fromJson(json['tipoUsuario'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    if (this.tipoUsuario != null) {
      data['tipoUsuario'] = this.tipoUsuario!.toJson();
    }
    return data;
  }

  static Future<String?> recuperarToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }
}

class TipoUsuario {
  int? id;
  String? descricao;

  TipoUsuario({this.id, this.descricao});

  TipoUsuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }
}

import 'dart:convert';

import 'package:avar/core/app_export.dart';
import 'package:avar/domain/connection.dart';

class Localidade {
  int? id;
  String? nome;
  Andar? andar;

  Localidade({this.id, this.nome, this.andar});

  Localidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    andar = json['andar'] != null ? new Andar.fromJson(json['andar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.andar != null) {
      data['andar'] = this.andar!.toJson();
    }
    return data;
  }
}

class Complexo extends Connection {
  int? id;
  String? nome;

  Complexo({this.id, this.nome});

  Complexo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Complexo> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }

  Future<List<Map<String, dynamic>>> listarComplexos() async {
    var response = await getHttp(montaURL(URIsAPI.uri_complexos, null));

    if (response.statusCode == 200) {
      List complexos0 = jsonDecode(utf8.decode(response.bodyBytes));

      var complexos =
          complexos0.map((json) => Complexo.fromJson(json)).toList();
      return Complexo.convertListToMapList(complexos);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class Predio extends Connection {
  int? id;
  String? nome;
  Complexo? complexo;

  Predio({this.id, this.nome, this.complexo});

  Predio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    complexo =
        json['complexo'] != null ? Complexo.fromJson(json['complexo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    if (complexo != null) {
      data['complexo'] = complexo!.toJson();
    }
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Predio> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }

  Future<List<Map<String, dynamic>>> listarPredios(int complexo) async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_predios, {'complexo': '$complexo'}));

    if (response.statusCode == 200) {
      List predios0 = jsonDecode(utf8.decode(response.bodyBytes));

      var predios = predios0.map((json) => Predio.fromJson(json)).toList();
      return Predio.convertListToMapList(predios);
    } else {
      throw Exception();
    }
  }
}

class Andar extends Connection {
  int? id;
  String? nome;
  Predio? predio;

  Andar({this.id, this.nome, this.predio});

  Andar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    predio = json['predio'] != null ? Predio.fromJson(json['predio']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    if (predio != null) {
      data['predio'] = predio!.toJson();
    }
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Andar> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }

  Future<List<Map<String, dynamic>>> listarAndares(int predio) async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_andares, {'predio': '$predio'}));

    if (response.statusCode == 200) {
      List andares0 = jsonDecode(utf8.decode(response.bodyBytes));

      var andares = andares0.map((json) => Andar.fromJson(json)).toList();
      return Andar.convertListToMapList(andares);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class Comodo extends Connection {
  int? id;
  String? nome;
  Andar? andar;

  Comodo({this.id, this.nome, this.andar});

  Comodo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    andar = json['andar'] != null ? Andar.fromJson(json['andar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    if (andar != null) {
      data['andar'] = andar!.toJson();
    }
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Comodo> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }

  Future<List<Map<String, dynamic>>> listarComodos(int andar) async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_comodos, {'andar': '$andar'}));

    if (response.statusCode == 200) {
      List comodo0 = jsonDecode(utf8.decode(response.bodyBytes));

      var comodo = comodo0.map((json) => Comodo.fromJson(json)).toList();
      return Comodo.convertListToMapList(comodo);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

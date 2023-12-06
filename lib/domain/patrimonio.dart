import 'dart:convert';
import 'package:avar/core/app_export.dart';

import 'package:avar/core/utils/api_uris.dart';
import 'package:avar/domain/connection.dart';

class PatrimonioListar {
  String? id;
  String? tombamento;
  String? descricao;
  String? estado;
  String? tipo;
  bool? alienado;
  String? comodo;
  String? andar;
  String? predio;
  String? complexo;

  PatrimonioListar(
      {this.id,
      this.tombamento,
      this.descricao,
      this.estado,
      this.tipo,
      this.alienado,
      this.comodo,
      this.andar,
      this.predio,
      this.complexo});

  PatrimonioListar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tombamento = json['tombamento'];
    descricao = json['descricao'];
    estado = json['estado'];
    tipo = json['tipo'];
    alienado = json['alienado'];
    comodo = json['comodo'];
    andar = json['andar'];
    predio = json['predio'];
    complexo = json['complexo'];
  }
}

class PatrimonioCadastrar {
  String? tombamento;
  String? descricao;
  int? estado;
  int? tipo;
  int? localidade;
  bool? alienado;

  PatrimonioCadastrar(
      {this.tombamento,
      this.descricao,
      this.estado,
      this.tipo,
      this.localidade,
      this.alienado});

  PatrimonioCadastrar.fromJson(Map<String, dynamic> json) {
    tombamento = json['tombamento'];
    descricao = json['descricao'];
    estado = json['estado'];
    tipo = json['tipo'];
    localidade = json['localidade'];
    alienado = json['alienado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tombamento'] = tombamento;
    data['descricao'] = descricao;
    data['estado'] = estado;
    data['tipo'] = tipo;
    data['localidade'] = localidade;
    data['alienado'] = alienado;
    return data;
  }
}

class EstadoPatrimonio extends Connection {
  int? id;
  String? descricao;

  EstadoPatrimonio({this.id, this.descricao});

  EstadoPatrimonio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<EstadoPatrimonio> estadoPatrimonioList) {
    return estadoPatrimonioList
        .map((estadoPatrimonio) => estadoPatrimonio.toJson())
        .toList();
  }

  Future<List<Map<String, dynamic>>> listarEstados() async {
    var response = await getHttp(montaURL(URIsAPI.uri_estados_patrimono, null));

    if (response.statusCode == 200) {
      List estados0 = jsonDecode(utf8.decode(response.bodyBytes));

      var estados =
          estados0.map((json) => EstadoPatrimonio.fromJson(json)).toList();
      return EstadoPatrimonio.convertListToMapList(estados);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class TipoPatrimonio extends Connection {
  int? id;
  String? descricao;

  TipoPatrimonio({this.id, this.descricao});

  TipoPatrimonio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<TipoPatrimonio> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }

  Future<List<Map<String, dynamic>>> listarTipos() async {
    var response = await getHttp(montaURL(URIsAPI.uri_tipos_patrimono, null));

    if (response.statusCode == 200) {
      List tipos0 = jsonDecode(utf8.decode(response.bodyBytes));

      var tipos = tipos0.map((json) => TipoPatrimonio.fromJson(json)).toList();
      return TipoPatrimonio.convertListToMapList(tipos);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

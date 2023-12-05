import 'dart:convert';

import 'package:avar/domain/erro.dart';
import 'package:avar/domain/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class Connection extends Erro {
  Map<String, String> _getHttpHeader = {};
  Map<String, String> _postHttpHeader = {};
  Map<String, String> _putHttpHeader = {};

  Uri montaURL(String urlApi, Map<String, dynamic>? parametros) {
    if (parametros == null) {
      return Uri.parse(urlApi);
    } else {
      var url = Uri.parse(urlApi);
      return Uri.http(url.authority, url.path, parametros);
    }
  }

  Future<Response> getHttp(Uri url) async {
    String? token = await Usuario.recuperarToken();

    if (token == '' || token == null) {
      _getHttpHeader = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': ''
      };
    } else {
      _getHttpHeader = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      };
    }
    return await http.get(url, headers: _getHttpHeader);
  }

  Future<Response> postHttp(Uri url, Connection connection) async {
    String? token = await Usuario.recuperarToken();

    if (token == '' || token == null) {
      _postHttpHeader = {
        'Content-Type': 'application/json',
        'Authorization': ''
      };
    } else {
      _postHttpHeader = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
    }
    String body = jsonEncode(connection.toJson());
    return await http.post(
      url,
      headers: _postHttpHeader,
      body: body,
    );
  }

  Future<Response> putHttp(Uri url, Connection connection) async {
    String? token = await Usuario.recuperarToken();

    if (token == '' || token == null) {
      _putHttpHeader = {
        'Content-Type': 'application/json',
        'Authorization': ''
      };
    } else {
      _putHttpHeader = {
        'Content-Type': 'application/json',
        'Authorization': token
      };
    }
    String body = jsonEncode(connection.toJson());
    return await http.put(
      url,
      headers: _putHttpHeader,
      body: body,
    );
  }

  Map<String, dynamic> toJson();
}




    // if (token == '' || token == null) {
    //   _getHttpHeader = {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': ''
    //   };

    //   _postHttpHeader = {
    //     'Content-Type': 'application/json',
    //     'Authorization': ''
    //   };
    // } else {
    //   _getHttpHeader = {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': token
    //   };

    //   _postHttpHeader = {
    //     'Content-Type': 'application/json',
    //     'Authorization': token
    //   };
    // }
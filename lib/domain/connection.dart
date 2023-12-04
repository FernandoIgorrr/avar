import 'dart:convert';

import 'package:avar/domain/erro.dart';
import 'package:avar/domain/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class Connection extends Erro {
  Map<String, String> _getHttpHeader = {};
  Map<String, String> _postHttpHeader = {};

  Connection() {}

  Future<void> _montaHeader() async {}

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
    print(_getHttpHeader);
    return await http.get(url, headers: _getHttpHeader);
  }

  Future<Response> postHttp(Uri url, Connection connection) async {
    String body = jsonEncode(connection.toJson());
    return await http.post(
      url,
      headers: _postHttpHeader,
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
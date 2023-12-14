import 'dart:convert';

import 'package:avar/domain/connection.dart';
import 'package:avar/presentation/supervisor_home_page/bolsista_opcoes_page/bolsista_editar_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:avar/core/app_export.dart';

class UsuarioTrocaSenha extends Connection {
  String? id;
  String? senhaAntiga;
  String? senhaNova;

  UsuarioTrocaSenha({this.id, this.senhaAntiga, this.senhaNova});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['senha_antiga'] = senhaAntiga;
    data['senha_nova'] = senhaNova;

    return data;
  }
}

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

  static Future<String?> recuperarHomePage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('home_page');
  }

  static Future<String?> recuperarLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('login');
  }

  static Future<String?> recuperarID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('id');
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

class BolsistaListar extends Connection {
  String? id;
  String? matricula;
  String? login;
  String? nome;
  String? email;
  String? telefone;
  String? tipo;
  String? status;
  String? dataChegada;
  String? dataSaida;

  BolsistaListar(
      {this.id,
      this.matricula,
      this.login,
      this.nome,
      this.email,
      this.telefone,
      this.tipo,
      this.status,
      this.dataChegada,
      this.dataSaida});

  BolsistaListar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matricula = json['matricula'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    tipo = json['tipo'];
    status = json['status'];
    dataChegada = json['data_chegada'];
    dataSaida = json['data_saida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['matricula'] = matricula;
    data['login'] = login;
    data['nome'] = nome;
    data['email'] = email;
    data['telefone'] = telefone;
    data['tipo'] = tipo;
    data['status'] = status;
    data['data_chegada'] = dataChegada;
    data['data_saida'] = dataSaida;
    return data;
  }

  Future<List<BolsistaListar>> listarBolsistasTudo() async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_listar_bolsistas_tudo, null));

    if (response.statusCode == 200) {
      List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
      return listaPatrimonios
          .map((json) => BolsistaListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  FutureBuilder<List<BolsistaListar>> listarBolsistasWidget(
      Future<List<BolsistaListar>>? future) {
    return FutureBuilder<List<BolsistaListar>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    BolsistaListar bolsistaListar = snapshot.data![index];
                    return Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(bottom: 15.v),
                      decoration: BoxDecoration(
                          color: appTheme.blackLight,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ExpansionTile(
                        title: Align(
                          alignment: const Alignment(0.2, 0),
                          child: Text(bolsistaListar.nome!),
                        ),
                        subtitle: Align(
                          alignment: const Alignment(0.2, 0),
                          child: Text(
                              "${bolsistaListar.matricula}   |   ${bolsistaListar.login}"),
                        ),
                        collapsedIconColor: appTheme.blueGray100,
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        children: [
                          Text(
                            bolsistaListar.email!,
                            style: CustomTextStyles.titleSmallOnblueGray100,
                          ),
                          Text(
                            bolsistaListar.telefone!,
                            style: CustomTextStyles.titleSmallOnblueGray100,
                          ),
                          Text(
                            bolsistaListar.tipo!,
                            style: CustomTextStyles.titleSmallOnblueGray100,
                          ),
                          Text(
                            bolsistaListar.status!,
                            style: CustomTextStyles.titleSmallOnblueGray100,
                          ),
                          Text(
                            bolsistaListar.dataChegada!,
                            style: CustomTextStyles.titleSmallOnblueGray100,
                          ),
                          Text(
                            bolsistaListar.dataSaida ?? " ",
                            style: CustomTextStyles.titleSmallOnblueGray100,
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomElevatedButton(
                                buttonStyle:
                                    CustomButtonStyles.fillRedAccentBotLeft,
                                buttonTextStyle:
                                    CustomTextStyles.titleMediumOnblueGray100,
                                text: "Desligar",
                                width: 170.h,
                                height: 40.v,
                              ),
                              CustomElevatedButton(
                                  buttonStyle:
                                      CustomButtonStyles.fillGreenLightBotRight,
                                  buttonTextStyle:
                                      CustomTextStyles.titleMediumOnPrimary,
                                  text: "Editar",
                                  width: 175.h,
                                  height: 40.v,
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    EditarBolsistaPage(
                                                      bolsista: bolsistaListar,
                                                    ))),
                                      }),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 0);
                  },
                  itemCount: snapshot.data!.length));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const LinearProgressIndicator();
      },
    );
  }
}

class BolsistaCadastrar extends Connection {
  String? id;
  String? matricula;
  String? login;
  String? nome;
  String? email;
  String? telefone;
  int? tipoBolsista;
  DateTime? dataChegada;

  BolsistaCadastrar(
      {this.id,
      this.matricula,
      this.login,
      this.nome,
      this.email,
      this.telefone,
      this.tipoBolsista,
      this.dataChegada});

  BolsistaCadastrar.fromJson(Map<String, dynamic> json) {
    matricula = json['matricula'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    tipoBolsista = json['tipo_bolsista'];
    dataChegada = json['data_chegada'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['matricula'] = matricula;
    data['login'] = login;
    data['nome'] = nome;
    data['email'] = email;
    data['telefone'] = telefone;
    data['tipo_bolsista'] = tipoBolsista;
    data['data_chegada'] = DateFormat('dd-MM-yyyy').format(dataChegada!);
    return data;
  }
}

class TipoBolsista extends Connection {
  int? id;
  String? descricao;

  TipoBolsista({this.id, this.descricao});

  TipoBolsista.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  List<Map<String, dynamic>> convertListToMapList(List<TipoBolsista> tipoList) {
    return tipoList.map((modelo) => modelo.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> listarTipos() async {
    var response = await getHttp(montaURL(URIsAPI.uri_tipos_bolsista, null));

    if (response.statusCode == 200) {
      List tipos0 = jsonDecode(utf8.decode(response.bodyBytes));

      var tipos = tipos0.map((json) => TipoBolsista.fromJson(json)).toList();
      return convertListToMapList(tipos);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

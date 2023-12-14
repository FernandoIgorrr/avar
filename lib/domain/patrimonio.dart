import 'dart:convert';
import 'package:avar/core/app_export.dart';
import 'package:avar/domain/connection.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/usuario.dart';
import 'package:avar/presentation/patrimonios_home_page/editar_patrimonio_page/editar_patrimonio_page.dart';
import 'package:avar/presentation/patrimonios_home_page/manejar_patrimonio_page/manejar_patrimonio_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Patrimonio extends Connection {
  String? id;
  String? tombamento;
  String? descricao;
  EstadoPatrimonio? estado;
  TipoPatrimonio? tipoPatrimonio;
  Localidade? localidade;
  bool? alienado;

  Patrimonio(
      {this.id,
      this.tombamento,
      this.descricao,
      this.estado,
      this.tipoPatrimonio,
      this.localidade,
      this.alienado});

  Patrimonio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tombamento = json['tombamento'];
    descricao = json['descricao'];
    estado = json['estado'] != null
        ? new EstadoPatrimonio.fromJson(json['estado'])
        : null;
    tipoPatrimonio = json['tipo_patrimonio'] != null
        ? new TipoPatrimonio.fromJson(json['tipo_patrimonio'])
        : null;
    localidade = json['localidade'] != null
        ? new Localidade.fromJson(json['localidade'])
        : null;
    alienado = json['alienado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tombamento'] = this.tombamento;
    data['descricao'] = this.descricao;
    if (this.estado != null) {
      data['estado'] = this.estado!.toJson();
    }
    if (this.tipoPatrimonio != null) {
      data['tipo_patrimonio'] = this.tipoPatrimonio!.toJson();
    }
    if (this.localidade != null) {
      data['localidade'] = this.localidade!.toJson();
    }
    data['alienado'] = this.alienado;
    return data;
  }

  Future<Patrimonio> getPatrimonio(String id) async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_get_patrimonio, {"id": id}));
    if (response.statusCode == 200) {
      return Patrimonio.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class PatrimonioListar extends Connection {
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

  Future<List<PatrimonioListar>> listarPatrimoniosTudo() async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_listar_patrimonios_tudo, null));

    if (response.statusCode == 200) {
      List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
      return listaPatrimonios
          .map((json) => PatrimonioListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tombamento'] = tombamento;
    data['descricao'] = descricao;
    data['estado'] = estado;
    data['tipo'] = tipo;
    data['alienado'] = alienado;
    data['comodo'] = comodo;
    data['andar'] = andar;
    data['predio'] = predio;
    data['complexo'] = complexo;
    return data;
  }

  Future<List<PatrimonioListar>> listarPatrimoniosPorComplexo(
      BuildContext context, String complexo) async {
    var response = await getHttp(montaURL(
        URIsAPI.uri_listar_patrimonios_por_complexo, {'complexo': complexo}));
    if (response.statusCode == 200) {
      List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
      return listaPatrimonios
          .map((json) => PatrimonioListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<PatrimonioListar>> listarPatrimoniosPorPredio(
      BuildContext context, Future<String> complexo0, String predio0) async {
    String _complexo = await complexo0;

    var response = await getHttp(montaURL(
        URIsAPI.uri_listar_patrimonios_por_predio,
        {'complexo': _complexo, 'predio': predio0}));
    if (response.statusCode == 200) {
      List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
      return listaPatrimonios
          .map((json) => PatrimonioListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<PatrimonioListar>> listarPatrimoniosPorAndar(
      BuildContext context,
      Future<String> complexo0,
      Future<String> predio0,
      Future<String> andar0) async {
    String _complexo = await complexo0;
    String _predio = await predio0;
    String _andar = await andar0;

    var response = await getHttp(montaURL(
        URIsAPI.uri_listar_patrimonios_por_andar,
        {'complexo': _complexo, 'predio': _predio, 'andar': _andar}));
    if (response.statusCode == 200) {
      List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
      return listaPatrimonios
          .map((json) => PatrimonioListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<PatrimonioListar>> listarPatrimoniosPorComodo(
      BuildContext context,
      Future<String> complexo0,
      Future<String> predio0,
      Future<String> andar0,
      Future<String> comodo0) async {
    String _complexo = await complexo0;
    String _predio = await predio0;
    String _andar = await andar0;
    String _comodo = await comodo0;

    var response = await getHttp(montaURL(
        URIsAPI.uri_listar_patrimonios_por_comodo, {
      'complexo': _complexo,
      'predio': _predio,
      'andar': _andar,
      'comodo': _comodo
    }));
    if (response.statusCode == 200) {
      List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
      return listaPatrimonios
          .map((json) => PatrimonioListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<PatrimonioListar>> listarPatrimoniosPorTipo(
      BuildContext context, String tipo) async {
    var response = await getHttp(
        montaURL(URIsAPI.uri_listar_patrimonios_por_tipo, {'tipo': tipo}));
    if (response.statusCode == 200) {
      List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
      return listaPatrimonios
          .map((json) => PatrimonioListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  FutureBuilder<List<PatrimonioListar>> listarPatrimoniosWidget(
      Future<List<PatrimonioListar>>? future) {
    return FutureBuilder<List<PatrimonioListar>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.separated(
                //padding: const EdgeInsets.all(20.0),

                shrinkWrap: true,
                itemBuilder: (context, index) {
                  PatrimonioListar patrimonio = snapshot.data![index];
                  Patrimonio patrimonio0 = Patrimonio();
                  String alienado = patrimonio.alienado! ? "Alienado" : "Ativo";
                  CustomElevatedButton botaoAlienar = patrimonio.alienado!
                      ? CustomElevatedButton(
                          buttonStyle: CustomButtonStyles.fillPrimaryBotLeft,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnblueGray100,
                          text: "Alienar",
                          width: 110.h,
                          height: 40.v,
                        )
                      : CustomElevatedButton(
                          buttonStyle: CustomButtonStyles.fillRedAccentBotLeft,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnblueGray100,
                          text: "Alienar",
                          width: 110.h,
                          height: 40.v,
                          onPressed: () async {
                            try {
                              String? usuarioId = await Usuario.recuperarID();
                              AlienamentoCadastrar alienamentoCadastrar =
                                  AlienamentoCadastrar(
                                      patrimonio: patrimonio.id,
                                      usuario: usuarioId,
                                      data: DateTime.now());

                              var response = await alienamentoCadastrar.putHttp(
                                  montaURL(URIsAPI.uri_alienar, null),
                                  alienamentoCadastrar);
                              if (response.statusCode == 202) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.greenAccent,
                                  content: Text(response.body,
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: appTheme.black900)),
                                  behavior: SnackBarBehavior.floating,
                                  dismissDirection: DismissDirection.up,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height -
                                              210,
                                      left: 15,
                                      right: 15),
                                  duration: const Duration(seconds: 2),
                                ));
                              }
                            } catch (e) {}
                          },
                        );
                  return Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: appTheme.blackLight,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ExpansionTile(
                      title: Align(
                        alignment: const Alignment(0.2, 0),
                        child: Text(
                          patrimonio.tombamento!,
                        ),
                      ),
                      subtitle: Align(
                          alignment: const Alignment(0.2, 0),
                          child: Text(
                              "${patrimonio.tipo!} - ${patrimonio.predio!}")),
                      collapsedIconColor: appTheme.blueGray100,
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 0.v, horizontal: 0.h),
                      children: <Widget>[
                        //Padding(padding: EdgeInsets.only(top: 50.adaptSize)),
                        Container(
                          // Defina a cor de fundo desejada aqui
                          color: appTheme.blueGray100,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            patrimonio.descricao!,
                            style: CustomTextStyles.titleSmallOnPrimary,
                          ),
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          patrimonio.estado!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Container(
                          color: appTheme.blueGray100,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            alienado,
                            style: CustomTextStyles.titleSmallOnPrimary,
                          ),
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          patrimonio.complexo!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          patrimonio.predio!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          patrimonio.andar!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          patrimonio.comodo!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        SizedBox(height: 15.v),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            botaoAlienar,
                            CustomElevatedButton(
                                buttonStyle:
                                    CustomButtonStyles.fillPrimarySquare,
                                buttonTextStyle:
                                    CustomTextStyles.titleMediumOnblueGray100,
                                text: "Editar",
                                width: 105.h,
                                height: 40.v,
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  EditarPatrimonioPage(
                                                      patrimonio: patrimonio))),
                                    }),
                            CustomElevatedButton(
                              buttonStyle:
                                  CustomButtonStyles.fillGreenLightBotRight,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary,
                              text: "Manejar",
                              width: 110.h,
                              height: 40.v,
                              onPressed: () async => {
                                patrimonio0 = await patrimonio0
                                    .getPatrimonio(patrimonio.id!),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ManejarPatrimonioPage(
                                            patrimonio: patrimonio0))),
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 0);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const LinearProgressIndicator();
        });
  }
}

class PatrimonioCadastrar extends Connection {
  String? id;
  String? tombamento;
  String? descricao;
  int? estado;
  int? tipo;
  int? localidade;
  bool? alienado;

  PatrimonioCadastrar(
      {this.id,
      this.tombamento,
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
    data['id'] = id;
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

class ManejoCadastrar extends Connection {
  String? patrimonio;
  String? usuario;
  int? comodoAnterior;
  int? comodoPosterior;
  DateTime? dataManejo;

  ManejoCadastrar(
      {this.patrimonio,
      this.usuario,
      this.comodoAnterior,
      this.comodoPosterior,
      this.dataManejo});

  ManejoCadastrar.fromJson(Map<String, dynamic> json) {
    patrimonio = json['patrimonio'];
    usuario = json['usuario'];
    comodoAnterior = json['comodo_anterior'];
    comodoPosterior = json['comodo_posterior'];
    dataManejo = json['data_manejo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patrimonio'] = patrimonio;
    data['usuario'] = usuario;
    data['comodo_anterior'] = comodoAnterior;
    data['comodo_posterior'] = comodoPosterior;
    data['data_manejo'] = DateFormat('dd-MM-yyyy').format(dataManejo!);
    return data;
  }
}

class ManejoListar extends Connection {
  int? id;
  String? tombamento;
  String? tipo;
  String? data;
  String? nome;
  String? complexoAnterior;
  String? predioAnterior;
  String? andarAnterior;
  String? comodoAnterior;
  String? complexoPosterior;
  String? predioPosterior;
  String? andarPosterior;
  String? comodoPosterior;

  ManejoListar(
      {this.id,
      this.tombamento,
      this.tipo,
      this.data,
      this.nome,
      this.complexoAnterior,
      this.predioAnterior,
      this.andarAnterior,
      this.comodoAnterior,
      this.complexoPosterior,
      this.predioPosterior,
      this.andarPosterior,
      this.comodoPosterior});

  ManejoListar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tombamento = json['tombamento'];
    tipo = json['tipo'];
    data = json['data'];
    nome = json['nome'];
    complexoAnterior = json['complexo_anterior'];
    predioAnterior = json['predio_anterior'];
    andarAnterior = json['andar_anterior'];
    comodoAnterior = json['comodo_anterior'];
    complexoPosterior = json['complexo_posterior'];
    predioPosterior = json['predio_posterior'];
    andarPosterior = json['andar_posterior'];
    comodoPosterior = json['comodo_posterior'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tombamento'] = this.tombamento;
    data['tipo'] = this.tipo;
    data['data'] = this.data;
    data['nome'] = this.nome;
    data['complexo_anterior'] = this.complexoAnterior;
    data['predio_anterior'] = this.predioAnterior;
    data['andar_anterior'] = this.andarAnterior;
    data['comodo_anterior'] = this.comodoAnterior;
    data['complexo_posterior'] = this.complexoPosterior;
    data['predio_posterior'] = this.predioPosterior;
    data['andar_posterior'] = this.andarPosterior;
    data['comodo_posterior'] = this.comodoPosterior;
    return data;
  }

  Future<List<ManejoListar>> listarManejosTudo() async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_listar_manejos_tudo, null));

    if (response.statusCode == 200) {
      List listaManejos = jsonDecode(utf8.decode(response.bodyBytes));
      return listaManejos.map((json) => ManejoListar.fromJson(json)).toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  FutureBuilder<List<ManejoListar>> listarManejosWidget(
      Future<List<ManejoListar>>? future) {
    return FutureBuilder<List<ManejoListar>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.separated(
                //padding: const EdgeInsets.all(20.0),

                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ManejoListar manejo = snapshot.data![index];
                  return Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: appTheme.blackLight,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ExpansionTile(
                      title: Align(
                        alignment: const Alignment(0.2, 0),
                        child: Text(
                          manejo.tombamento!,
                        ),
                      ),
                      subtitle: Align(
                          alignment: const Alignment(0.2, 0),
                          child: Text(
                              "${manejo.nome} | ${manejo.tipo} | ${manejo.data}")),
                      collapsedIconColor: appTheme.blueGray100,
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 0.v, horizontal: 0.h),
                      children: <Widget>[
                        //Padding(padding: EdgeInsets.only(top: 50.adaptSize)),

                        Text(
                          manejo.id.toString(),
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          manejo.complexoAnterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          manejo.predioAnterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          manejo.andarAnterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          manejo.comodoAnterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.v),
                        SizedBox(
                          width: double.maxFinite,
                          height: 2,
                          child: Container(color: appTheme.blueGray100),
                        ),
                        SizedBox(height: 8.v),
                        Text(
                          manejo.complexoPosterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          manejo.predioPosterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          manejo.andarPosterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          manejo.comodoPosterior!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 0);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const LinearProgressIndicator();
        });
  }
}

class AlienamentoCadastrar extends Connection {
  String? id;
  String? patrimonio;
  String? usuario;
  DateTime? data;

  AlienamentoCadastrar({this.id, this.patrimonio, this.usuario, this.data});

  AlienamentoCadastrar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patrimonio = json['patrimonio'];
    usuario = json['usuario'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patrimonio'] = this.patrimonio;
    data['usuario'] = this.usuario;
    data['data'] = DateFormat('dd-MM-yyyy').format(this.data!);
    return data;
  }
}

class AlienamentoListar extends Connection {
  int? id;
  String? tombamento;
  String? tipo;
  String? nome;
  String? data;

  AlienamentoListar(
      {this.id, this.tombamento, this.tipo, this.nome, this.data});

  AlienamentoListar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tombamento = json['tombamento'];
    tipo = json['tipo'];
    nome = json['nome'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tombamento'] = this.tombamento;
    data['tipo'] = this.tipo;
    data['nome'] = this.nome;
    data['data'] = this.data;
    return data;
  }

  Future<List<AlienamentoListar>> listarAlienamentosTudo() async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_listar_alienamentos_tudo, null));

    if (response.statusCode == 200) {
      List listaAlienamentos = jsonDecode(utf8.decode(response.bodyBytes));
      return listaAlienamentos
          .map((json) => AlienamentoListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  FutureBuilder<List<AlienamentoListar>> listarAlienamentosWidget(
      Future<List<AlienamentoListar>>? future) {
    return FutureBuilder<List<AlienamentoListar>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.separated(
                //padding: const EdgeInsets.all(20.0),

                shrinkWrap: true,
                itemBuilder: (context, index) {
                  AlienamentoListar alienamento = snapshot.data![index];
                  return Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: appTheme.blackLight,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ExpansionTile(
                      title: Align(
                        alignment: const Alignment(0.2, 0),
                        child: Text(
                          alienamento.tombamento!,
                        ),
                      ),
                      subtitle: Align(
                          alignment: const Alignment(0.2, 0),
                          child: Text(
                              "${alienamento.nome} | ${alienamento.tipo} | ${alienamento.data}")),
                      collapsedIconColor: appTheme.blueGray100,
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 0.v, horizontal: 0.h),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 0);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const LinearProgressIndicator();
        });
  }
}

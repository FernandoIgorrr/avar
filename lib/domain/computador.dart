import 'package:avar/domain/connection.dart';
import 'package:avar/presentation/patrimonios_home_page/editar_computador_page/editar_computador_page.dart';
import 'package:flutter/material.dart';
import 'package:avar/core/app_export.dart';
import 'dart:convert';

class ComputadorListar extends Connection {
  String? id;
  String? tombamento;
  String? serial;
  String? modelo;
  String? sistemaOperacional;
  String? ram;
  String? ramDdr;
  String? hd;
  String? descricao;
  String? estado;
  bool? alienado;
  String? comodo;
  String? andar;
  String? predio;
  String? complexo;

  ComputadorListar(
      {this.id,
      this.tombamento,
      this.serial,
      this.modelo,
      this.sistemaOperacional,
      this.ram,
      this.ramDdr,
      this.hd,
      this.descricao,
      this.estado,
      this.alienado,
      this.comodo,
      this.andar,
      this.predio,
      this.complexo})
      : super();

  ComputadorListar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tombamento = json['tombamento'];
    serial = json['serial'];
    modelo = json['modelo'];
    sistemaOperacional = json['sistema_operacional'];
    ram = json['ram'];
    ramDdr = json['ram_ddr'];
    hd = json['hd'];
    descricao = json['descricao'];
    estado = json['estado'];
    alienado = json['alienado'];
    comodo = json['comodo'];
    andar = json['andar'];
    predio = json['predio'];
    complexo = json['complexo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tombamento'] = this.tombamento;
    data['serial'] = this.serial;
    data['modelo'] = this.modelo;
    data['sistema_operacional'] = this.sistemaOperacional;
    data['ram'] = this.ram;
    data['ram_ddr'] = this.ramDdr;
    data['hd'] = this.hd;
    data['descricao'] = this.descricao;
    data['estado'] = this.estado;
    data['alienado'] = this.alienado;
    data['comodo'] = this.comodo;
    data['andar'] = this.andar;
    data['predio'] = this.predio;
    data['complexo'] = this.complexo;
    return data;
  }

  Future<List<ComputadorListar>> listarComputadoresTudo(
      BuildContext context) async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_listar_computadores_tudo, null));

    if (response.statusCode == 200) {
      List listaComputadores = jsonDecode(utf8.decode(response.bodyBytes));
      return listaComputadores
          .map((json) => ComputadorListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<ComputadorListar>> listarComputadoresPorComplexo(
      BuildContext context, String complexo) async {
    var response = await getHttp(montaURL(
        URIsAPI.uri_listar_computadores_por_complexo, {'complexo': complexo}));
    if (response.statusCode == 200) {
      List listaComputadores = jsonDecode(utf8.decode(response.bodyBytes));
      return listaComputadores
          .map((json) => ComputadorListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<ComputadorListar>> listarComputadoresPorPredio(
      BuildContext context, String predio) async {
    var response = await getHttp(montaURL(
        URIsAPI.uri_listar_computadores_por_predio, {'predio': predio}));
    if (response.statusCode == 200) {
      List listaComputadores = jsonDecode(utf8.decode(response.bodyBytes));
      return listaComputadores
          .map((json) => ComputadorListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<ComputadorListar>> listarPatrimoniosPorAndar(
      Future<String> predio0, Future<String> andar0) async {
    String predio = await predio0;
    String andar = await andar0;
    var response = await getHttp(montaURL(
        URIsAPI.uri_listar_computadoress_por_andar,
        {'predio': predio, 'andar': andar}));

    if (response.statusCode == 200) {
      List listarComputadores = jsonDecode(utf8.decode(response.bodyBytes));
      return listarComputadores
          .map((json) => ComputadorListar.fromJson(json))
          .toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  FutureBuilder<List<ComputadorListar>> listarComputadoresWidget(
      Future<List<ComputadorListar>>? future) {
    return FutureBuilder<List<ComputadorListar>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ComputadorListar computador = snapshot.data![index];
                  return Container(
                    width: double.maxFinite,
                    //margin: EdgeInsets.all(10.h),
                    margin: EdgeInsets.only(bottom: 15.v),
                    decoration: BoxDecoration(
                      color: appTheme.blackLight,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ExpansionTile(
                      title: Align(
                        alignment: const Alignment(0.2, 0),
                        child: Text(
                          computador.tombamento!,
                        ),
                      ),
                      subtitle: Align(
                          alignment: const Alignment(0.2, 0),
                          child: Text(
                              "${computador.modelo!}     |     ${computador.predio!}")),
                      collapsedIconColor: appTheme.blueGray100,
                      tilePadding:
                          EdgeInsets.symmetric(vertical: 0.v, horizontal: 0.h),
                      children: <Widget>[
                        Text(computador.descricao!),
                        Text(computador.estado!),
                        Text(computador.serial!),
                        Text(computador.sistemaOperacional!),
                        Text(computador.ram!),
                        Text(computador.ramDdr!),
                        Text(computador.hd!),
                        Text(computador.complexo!),
                        Text(computador.predio!),
                        Text(computador.andar!),
                        Text(computador.comodo!),
                        SizedBox(
                          height: 15.v,
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomElevatedButton(
                              buttonStyle:
                                  CustomButtonStyles.fillRedAccentBotLeft,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary,
                              text: "Alienar",
                              width: 110.h,
                              height: 30.v,
                            ),
                            CustomElevatedButton(
                                buttonStyle:
                                    CustomButtonStyles.fillPrimarySquare,
                                buttonTextStyle:
                                    CustomTextStyles.titleMediumOnPrimary,
                                text: "Editar",
                                width: 120.h,
                                height: 30.v,
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  EditarComputadorPage(
                                                      computador: computador))),
                                    }),
                            CustomElevatedButton(
                              buttonStyle:
                                  CustomButtonStyles.fillGreenLightBotRight,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary,
                              text: "Manejar",
                              width: 115.h,
                              height: 30.v,
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

class ComputadorCadastrar extends Connection {
  String? id;
  String? tombamento;
  String? descricao;
  int? estado;
  int? localidade;
  bool? alienado;
  int? ram;
  int? ramDdr;
  int? hd;
  int? modelo;
  int? sistemaOperacional;
  String? serial;

  ComputadorCadastrar(
      {this.id,
      this.tombamento,
      this.descricao,
      this.estado,
      this.localidade,
      this.alienado,
      this.ram,
      this.ramDdr,
      this.hd,
      this.modelo,
      this.sistemaOperacional,
      this.serial});

  ComputadorCadastrar.fromJson(Map<String, dynamic> json) {
    tombamento = json['tombamento'];
    descricao = json['descricao'];
    estado = json['estado'];
    localidade = json['localidade'];
    alienado = json['alienado'];
    ram = json['ram'];
    ramDdr = json['ram_ddr'];
    hd = json['hd'];
    modelo = json['modelo'];
    sistemaOperacional = json['sistema_operacional'];
    serial = json['serial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tombamento'] = this.tombamento;
    data['descricao'] = this.descricao;
    data['estado'] = this.estado;
    data['localidade'] = this.localidade;
    data['alienado'] = this.alienado;
    data['ram'] = this.ram;
    data['ram_ddr'] = this.ramDdr;
    data['hd'] = this.hd;
    data['modelo'] = this.modelo;
    data['sistema_operacional'] = this.sistemaOperacional;
    data['serial'] = this.serial;
    return data;
  }
}

class Modelo extends Connection {
  int? id;
  String? descricao;

  Modelo({this.id, this.descricao});

  Modelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Modelo> modeloList) {
    return modeloList.map((modelo) => modelo.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> listarModelos() async {
    var response = await getHttp(montaURL(URIsAPI.uri_modelos, null));

    if (response.statusCode == 200) {
      List modelos0 = jsonDecode(utf8.decode(response.bodyBytes));

      var modelos = modelos0.map((json) => Modelo.fromJson(json)).toList();
      return Modelo.convertListToMapList(modelos);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  alterarDados() async {}
}

class SistemaOperacional extends Connection {
  int? id;
  String? descricao;

  SistemaOperacional({this.id, this.descricao});

  SistemaOperacional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<SistemaOperacional> sistemaOperacionalList) {
    return sistemaOperacionalList.map((so) => so.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> listarSistemasOperacionais() async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_sistemas_operacionais, null));

    if (response.statusCode == 200) {
      List os0 = jsonDecode(utf8.decode(response.bodyBytes));

      var os = os0.map((json) => SistemaOperacional.fromJson(json)).toList();
      return SistemaOperacional.convertListToMapList(os);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class RAM extends Connection {
  int? id;
  String? descricao;

  RAM({this.id, this.descricao});

  RAM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(List<RAM> ramList) {
    return ramList.map((ram) => ram.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> listarRams() async {
    var response = await getHttp(montaURL(URIsAPI.uri_ram, null));

    if (response.statusCode == 200) {
      List ram0 = jsonDecode(utf8.decode(response.bodyBytes));

      var ram = ram0.map((json) => RAM.fromJson(json)).toList();
      return RAM.convertListToMapList(ram);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class RAMDDR extends Connection {
  int? id;
  String? descricao;

  RAMDDR({this.id, this.descricao});

  RAMDDR.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<RAMDDR> ramddrList) {
    return ramddrList.map((ramddr) => ramddr.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> listarRamsDdr() async {
    var response = await getHttp(montaURL(URIsAPI.uri_ram_ddr, null));

    if (response.statusCode == 200) {
      List ramddr0 = jsonDecode(utf8.decode(response.bodyBytes));

      var ramddr = ramddr0.map((json) => RAMDDR.fromJson(json)).toList();
      return RAMDDR.convertListToMapList(ramddr);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class HD extends Connection {
  int? id;
  String? descricao;

  HD({this.id, this.descricao});

  HD.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(List<HD> hdList) {
    return hdList.map((hd) => hd.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> listarHds() async {
    var response = await getHttp(montaURL(URIsAPI.uri_hd, null));

    if (response.statusCode == 200) {
      List hd0 = jsonDecode(utf8.decode(response.bodyBytes));

      var hd = hd0.map((json) => HD.fromJson(json)).toList();
      return HD.convertListToMapList(hd);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

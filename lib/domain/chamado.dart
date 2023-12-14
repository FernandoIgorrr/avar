import 'dart:convert';
import 'package:avar/core/app_export.dart';
import 'package:avar/domain/connection.dart';
import 'package:avar/domain/usuario.dart';
import 'package:avar/presentation/chamado_home_page/editar_chamado_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChamadoCadastrar extends Connection {
  String? titulo;
  String? descricao;
  String? criador;
  int? localidade;
  int? tipo;
  DateTime? dataAbertura;

  ChamadoCadastrar(
      {this.criador,
      this.dataAbertura,
      this.titulo,
      this.descricao,
      this.localidade,
      this.tipo});

  ChamadoCadastrar.fromJson(Map<String, dynamic> json) {
    criador = json['criador'];
    dataAbertura = json['data_abertura'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    localidade = json['localidade'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['criador'] = this.criador;
    data['data_abertura'] = DateFormat('dd-MM-yyyy').format(this.dataAbertura!);
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['localidade'] = this.localidade;
    data['tipo'] = this.tipo;
    return data;
  }
}

class TipoChamado extends Connection {
  int? id;
  String? descricao;

  TipoChamado({this.id, this.descricao});

  TipoChamado.fromJson(Map<String, dynamic> json) {
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
      List<TipoChamado> TipoChamadoList) {
    return TipoChamadoList.map((tipoChamado) => tipoChamado.toJson()).toList();
  }

  Future<List<Map<String, dynamic>>> listarTipos() async {
    var response = await getHttp(montaURL(URIsAPI.uri_tipos_chamado, null));

    if (response.statusCode == 200) {
      List tipos0 = jsonDecode(utf8.decode(response.bodyBytes));

      var tipos = tipos0.map((json) => TipoChamado.fromJson(json)).toList();
      return TipoChamado.convertListToMapList(tipos);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class EstadoChamado extends Connection {
  int? id;
  String? descricao;

  EstadoChamado({this.id, this.descricao});

  EstadoChamado.fromJson(Map<String, dynamic> json) {
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
      List<EstadoChamado> EstadoChamadoList) {
    return EstadoChamadoList.map((estadoChamado) => estadoChamado.toJson())
        .toList();
  }

  Future<List<Map<String, dynamic>>> listarEstados() async {
    var response = await getHttp(montaURL(URIsAPI.uri_estados_chamado, null));

    if (response.statusCode == 200) {
      List estados0 = jsonDecode(utf8.decode(response.bodyBytes));

      var estados =
          estados0.map((json) => EstadoChamado.fromJson(json)).toList();
      return EstadoChamado.convertListToMapList(estados);
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }
}

class ChamadoListar extends Connection {
  int? id;
  String? titulo;
  String? descricao;
  String? estado;
  String? tipo;
  String? criador;
  String? fechador;
  String? dataAbertura;
  String? dataFechamento;
  String? complexo;
  String? predio;
  String? andar;
  String? comodo;

  ChamadoListar(
      {this.id,
      this.titulo,
      this.descricao,
      this.estado,
      this.tipo,
      this.criador,
      this.fechador,
      this.dataAbertura,
      this.dataFechamento,
      this.complexo,
      this.predio,
      this.andar,
      this.comodo});

  ChamadoListar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    estado = json['estado'];
    tipo = json['tipo'];
    criador = json['criador'];
    fechador = json['fechador'];
    dataAbertura = json['data_abertura'];
    dataFechamento = json['data_fechamento'];
    complexo = json['complexo'];
    predio = json['predio'];
    andar = json['andar'];
    comodo = json['comodo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['estado'] = this.estado;
    data['tipo'] = this.tipo;
    data['criador'] = this.criador;
    data['fechador'] = this.fechador;
    data['data_abertura'] = this.dataAbertura;
    data['data_fechamento'] = this.dataFechamento;
    data['complexo'] = this.complexo;
    data['predio'] = this.predio;
    data['andar'] = this.andar;
    data['comodo'] = this.comodo;
    return data;
  }

  Future<List<ChamadoListar>> listarChamadosTudo() async {
    var response =
        await getHttp(montaURL(URIsAPI.uri_listar_chamados_tudo, null));

    if (response.statusCode == 200) {
      List listaChamados = jsonDecode(utf8.decode(response.bodyBytes));
      return listaChamados.map((json) => ChamadoListar.fromJson(json)).toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  Future<List<ChamadoListar>> listarChamadosPorEstado(
      BuildContext context, String estado) async {
    var response = await getHttp(
        montaURL(URIsAPI.uri_listar_chamados_por_estado, {'estado': estado}));
    if (response.statusCode == 200) {
      List chamadoListar = jsonDecode(utf8.decode(response.bodyBytes));
      return chamadoListar.map((json) => ChamadoListar.fromJson(json)).toList();
    } else {
      throw Exception("msg_erro_autorizacao".tr);
    }
  }

  FutureBuilder<List<ChamadoListar>> listarChamadosWidget(
      Future<List<ChamadoListar>>? future) {
    return FutureBuilder<List<ChamadoListar>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.separated(
                //padding: const EdgeInsets.all(20.0),

                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ChamadoListar chamado = snapshot.data![index];
                  //String fechado = chamado.estado == "fechado" ? "Fechado" : "Ativo";
                  CustomElevatedButton botaoAlienar = chamado.estado ==
                          "Fechado"
                      ? CustomElevatedButton(
                          buttonStyle: CustomButtonStyles.fillPrimaryBotLeft,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnblueGray100,
                          text: "Fechar",
                          width: 160.h,
                          height: 40.v,
                        )
                      : CustomElevatedButton(
                          buttonStyle: CustomButtonStyles.fillRedAccentBotLeft,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnblueGray100,
                          text: "Fechar",
                          width: 160.h,
                          height: 40.v,
                          onPressed: () async {
                            String? userId = await Usuario.recuperarID();
                            ChamadoFechar chamadoFechar = ChamadoFechar(
                                id: chamado.id,
                                fechador: userId,
                                dataFechamento: DateTime.now());
                            try {
                              var response = await chamadoFechar.putHttp(
                                  chamadoFechar.montaURL(
                                      URIsAPI.uri_fechar_chamados, null),
                                  chamadoFechar);

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
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.redAccent,
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
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text("Erro de conexão",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: appTheme.black900)),
                                behavior: SnackBarBehavior.floating,
                                dismissDirection: DismissDirection.up,
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height -
                                        210,
                                    left: 15,
                                    right: 15),
                                duration: const Duration(seconds: 2),
                              ));
                            }
                          },
                        );

                  CustomElevatedButton botaoEditar = chamado.estado == "Fechado"
                      ? CustomElevatedButton(
                          buttonStyle: CustomButtonStyles.fillPrimaryBotRight,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnblueGray100,
                          text: "Editar",
                          width: 165.h,
                          height: 40.v,
                        )
                      : CustomElevatedButton(
                          buttonStyle:
                              CustomButtonStyles.fillGreenLightBotRight,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnPrimary,
                          text: "Editar",
                          width: 165.h,
                          height: 40.v,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        EditarChamadoPage(chamado: chamado)));
                          });
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
                          chamado.id.toString(),
                        ),
                      ),
                      subtitle: Align(
                          alignment: const Alignment(0.2, 0),
                          child: Text("${chamado.tipo!} - ${chamado.predio!}")),
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
                            chamado.titulo!,
                            style: CustomTextStyles.titleSmallOnPrimary,
                          ),
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          chamado.descricao!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Container(
                          color: appTheme.blueGray100,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            chamado.estado!,
                            style: CustomTextStyles.titleSmallOnPrimary,
                          ),
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          chamado.criador!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Container(
                          color: appTheme.blueGray100,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            chamado.fechador ?? "Chamado não resolvido",
                            style: CustomTextStyles.titleSmallOnPrimary,
                          ),
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          chamado.dataAbertura.toString(),
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Container(
                          color: appTheme.blueGray100,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            chamado.dataFechamento ?? "-",
                            style: CustomTextStyles.titleSmallOnPrimary,
                          ),
                        ),
                        SizedBox(height: 8.adaptSize),

                        Text(
                          chamado.predio!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          chamado.andar!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        Text(
                          chamado.comodo!,
                          style: CustomTextStyles.titleSmallOnblueGray100,
                        ),
                        SizedBox(height: 8.adaptSize),
                        SizedBox(height: 15.v),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            botaoAlienar,
                            botaoEditar,
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

class ChamadoAlterar extends Connection {
  int? id;
  String? titulo;
  String? descricao;
  int? tipo;
  int? estado;

  ChamadoAlterar(
      {this.id, this.titulo, this.descricao, this.estado, this.tipo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['tipo'] = this.tipo;
    data['estado'] = this.estado;
    return data;
  }
}

class ChamadoFechar extends Connection {
  int? id;
  String? fechador;
  DateTime? dataFechamento;

  ChamadoFechar({
    this.id,
    this.fechador,
    this.dataFechamento,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fechador'] = this.fechador;
    data['data_fechamento'] =
        DateFormat('dd-MM-yyyy').format(this.dataFechamento!);
    return data;
  }
}

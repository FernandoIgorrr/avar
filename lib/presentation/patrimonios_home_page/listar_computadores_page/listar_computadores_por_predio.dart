import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class ListarComputadoresPorPredio extends StatefulWidget {
  const ListarComputadoresPorPredio({Key? key}) : super(key: key);

  @override
  State<ListarComputadoresPorPredio> createState() =>
      _ListarComputadoresPorPredioState();
}

class _ListarComputadoresPorPredioState
    extends State<ListarComputadoresPorPredio> {
  late Future<List<ComputadorListar>> computadores;

  TextEditingController _complexoController = TextEditingController();
  TextEditingController _predioController = TextEditingController();

  ValueNotifier<int> _reloadComplexo = ValueNotifier<int>(1);
  ValueNotifier<String> _reloadPredio = ValueNotifier<String>("CAMPUS I");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_por_predio".tr),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          decoration: AppDecoration.fillOnPrimary,
          child: Column(children: [
            ExpansionTile(
                collapsedIconColor: appTheme.blueGray100,
                tilePadding:
                    EdgeInsets.symmetric(vertical: 0.v, horizontal: 0.h),
                title: Align(
                  alignment: const Alignment(0.2, 0),
                  child: Text("lbl_localidade".tr),
                ),
                children: [
                  Column(children: [
                    SizedBox(height: 15.v),
                    FutureBuilder<Widget>(
                      future: _buildComplexo(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LinearProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else {
                          return snapshot.data ?? const SizedBox();
                        }
                      },
                    ),
                    SizedBox(height: 12.v),
                    ValueListenableBuilder<int>(
                      valueListenable: _reloadComplexo,
                      builder: (context, value, child) {
                        return FutureBuilder(
                          future: _buildPredio(context, value),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LinearProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Erro: ${snapshot.error}');
                            } else {
                              return snapshot.data ?? const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 15.v),
                  ]),
                ]),
            ValueListenableBuilder<String>(
                valueListenable: _reloadPredio,
                builder: (context, value, child) {
                  return FutureBuilder<List<ComputadorListar>>(
                      future: listarComputadoresPorPredio(_reloadPredio.value),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.separated(
                              //shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ComputadorListar computador =
                                    snapshot.data![index];
                                return Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(top: 15.v),
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
                                            "${computador.modelo!} - ${computador.predio!}")),
                                    collapsedIconColor: appTheme.blueGray100,
                                    tilePadding: EdgeInsets.symmetric(
                                        vertical: 0.v, horizontal: 0.h),
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
                                    ],
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 0);
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return const LinearProgressIndicator();
                      });
                }),
          ]),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }

  Future<Widget> _buildComplexo(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarComplexos();
    return CustomDropDownMenu(
      reloadElement: _reloadComplexo,
      descName: 'nome',
      selectedItemIdController: _complexoController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildPredio(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await listarPredios(value);
    _reloadPredio.value = items.first['nome'];
    return CustomDropDownMenuString(
      reloadElement: _reloadPredio,
      descName: 'nome',
      selectedItemIdController: _predioController,
      items: items,
      selectedItemId: items.first['nome'],
    );
  }

  Future<List<Map<String, dynamic>>> listarComplexos() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_complexos);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
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

  Future<List<Map<String, dynamic>>> listarPredios(int complexo) async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      final params = {'complexo': '$complexo'};
      var url = Uri.parse(
        URIsAPI.uri_predios,
      );
      final urlWithParams = Uri.http(url.authority, url.path, params);
      var response = await http.get(urlWithParams, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List predios0 = jsonDecode(utf8.decode(response.bodyBytes));

        var predios = predios0.map((json) => Predio.fromJson(json)).toList();
        return Predio.convertListToMapList(predios);
      } else {
        throw Exception();
      }
    }
  }

  Future<List<ComputadorListar>> listarComputadoresPorPredio(
      String predio) async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      final params = {'predio': predio};
      var url = Uri.parse(URIsAPI.uri_listar_computadores_por_predio);
      final urlWithParams = Uri.http(url.authority, url.path, params);

      print(urlWithParams);
      var response = await http.get(urlWithParams, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });

      if (response.statusCode == 200) {
        List listaComputadores = jsonDecode(utf8.decode(response.bodyBytes));
        return listaComputadores
            .map((json) => ComputadorListar.fromJson(json))
            .toList();
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<String?> recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

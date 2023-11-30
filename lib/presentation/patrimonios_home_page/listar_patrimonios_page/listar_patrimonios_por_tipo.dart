import 'package:avar/core/app_export.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class ListarPatrimoniosPorTipo extends StatefulWidget {
  const ListarPatrimoniosPorTipo({Key? key}) : super(key: key);

  @override
  State<ListarPatrimoniosPorTipo> createState() =>
      _ListarPatrimoniosPorTipoState();
}

class _ListarPatrimoniosPorTipoState extends State<ListarPatrimoniosPorTipo> {
  late Future<List<PatrimonioListar>> patrimonios;

  TextEditingController _tipoController = TextEditingController();

  ValueNotifier<String> _reloadTipo = ValueNotifier<String>("Cadeira");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_por_tipo".tr),
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
                  child: Text("lbl_tipo".tr),
                ),
                children: [
                  Column(children: [
                    SizedBox(height: 15.v),
                    FutureBuilder<Widget>(
                      future: _buildTipos(context),
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
                    SizedBox(height: 15.v),
                  ]),
                ]),
            ValueListenableBuilder<String>(
                valueListenable: _reloadTipo,
                builder: (context, value, child) {
                  return FutureBuilder<List<PatrimonioListar>>(
                      future: listarPatrimoniosPorTipo(_reloadTipo.value),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                PatrimonioListar patrimonio =
                                    snapshot.data![index];
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
                                        patrimonio.tombamento!,
                                      ),
                                    ),
                                    subtitle: Align(
                                        alignment: const Alignment(0.2, 0),
                                        child: Text(
                                            "${patrimonio.tipo!} - ${patrimonio.predio!}")),
                                    collapsedIconColor: appTheme.blueGray100,
                                    tilePadding: EdgeInsets.symmetric(
                                        vertical: 0.v, horizontal: 0.h),
                                    children: <Widget>[
                                      Text(patrimonio.descricao!),
                                      Text(patrimonio.estado!),
                                      Text(patrimonio.complexo!),
                                      Text(patrimonio.predio!),
                                      Text(patrimonio.andar!),
                                      Text(patrimonio.comodo!),
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

  Future<Widget> _buildTipos(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarTiposPatrimonio();
    return CustomDropDownMenuString(
      reloadElement: _reloadTipo,
      selectedItemIdController: _tipoController,
      items: items,
      selectedItemId: items.first['descricao'],
    );
  }

  Future<List<Map<String, dynamic>>> listarTiposPatrimonio() async {
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
      var url = Uri.parse(URIsAPI.uri_tipos_patrimono);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List tiposPatrimonio0 = jsonDecode(utf8.decode(response.bodyBytes));

        var tiposPatrimonio = tiposPatrimonio0
            .map((json) => TipoPatrimonio.fromJson(json))
            .toList();
        return TipoPatrimonio.convertListToMapList(tiposPatrimonio);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<PatrimonioListar>> listarPatrimoniosPorTipo(String tipo) async {
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
      final params = {'tipo': tipo};
      var url = Uri.parse(URIsAPI.uri_listar_patrimonios_por_tipo);
      final urlWithParams = Uri.http(url.authority, url.path, params);

      print(urlWithParams);
      var response = await http.get(urlWithParams, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });

      if (response.statusCode == 200) {
        List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
        return listaPatrimonios
            .map((json) => PatrimonioListar.fromJson(json))
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

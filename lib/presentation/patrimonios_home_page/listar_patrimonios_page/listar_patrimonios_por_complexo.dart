import 'package:avar/core/app_export.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class ListarPatrimoniosPorComplexo extends StatefulWidget {
  const ListarPatrimoniosPorComplexo({Key? key}) : super(key: key);

  @override
  State<ListarPatrimoniosPorComplexo> createState() =>
      _ListarPatrimonioPorComplexoState();
}

class _ListarPatrimonioPorComplexoState
    extends State<ListarPatrimoniosPorComplexo> {
  late Future<List<PatrimonioListar>> patrimonios;

  TextEditingController _complexoController = TextEditingController();

  ValueNotifier<String> _reloadComplexo = ValueNotifier<String>("CAMPUS");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_tudo".tr),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(children: [
            FutureBuilder<Widget>(
              future: _buildComplexo(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  return snapshot.data ?? const SizedBox();
                }
              },
            ),
            ValueListenableBuilder<String>(
                valueListenable: _reloadComplexo,
                builder: (context, value, child) {
                  return FutureBuilder<List<PatrimonioListar>>(
                      future:
                          listarPatrimoniosPorComplexo(_reloadComplexo.value),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            //padding: const EdgeInsets.all(20.0),

                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              PatrimonioListar patrimonio =
                                  snapshot.data![index];
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
    return CustomDropDownMenuString(
      reloadElement: _reloadComplexo,
      descName: 'nome',
      selectedItemIdController: _complexoController,
      items: items,
      selectedItemId: items.first['nome'],
    );
  }

  Future<List<Map<String, dynamic>>> listarComplexos() async {
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

  Future<List<PatrimonioListar>> listarPatrimoniosPorComplexo(
      String complexo) async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      final params = {'complexo': complexo};
      var url = Uri.parse(URIsAPI.uri_listar_patrimonios_por_complexo);
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

import 'package:avar/core/app_export.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class ListarPatrimoniosPorPredio extends StatefulWidget {
  const ListarPatrimoniosPorPredio({Key? key}) : super(key: key);

  @override
  State<ListarPatrimoniosPorPredio> createState() =>
      _ListarPatrimoniosPorPredioState();
}

class _ListarPatrimoniosPorPredioState
    extends State<ListarPatrimoniosPorPredio> {
  late Future<List<PatrimonioListar>> patrimonios;

  TextEditingController _complexoController = TextEditingController();
  TextEditingController _predioController = TextEditingController();

  ValueNotifier<int> _reloadComplexo = ValueNotifier<int>(1);
  ValueNotifier<String> _reloadPredio = ValueNotifier<String>("CAMPUS I");

  late Complexo complexo;
  late Predio predio;
  late PatrimonioListar patrimonio;

  @override
  void initState() {
    super.initState();

    complexo = Complexo();
    predio = Predio();
    patrimonio = PatrimonioListar();
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
                  return patrimonio.listarPatrimoniosWidget(
                      patrimonio.listarPatrimoniosPorPredio(
                          context, _getComplexoName(), value));
                }),
          ]),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<Widget> _buildComplexo(BuildContext context) async {
    List<Map<String, dynamic>> items = await complexo.listarComplexos();
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
    items = await predio.listarPredios(value);
    _reloadPredio.value = items.first['nome'];
    return CustomDropDownMenuString(
      reloadElement: _reloadPredio,
      descName: 'nome',
      selectedItemIdController: _predioController,
      items: items,
      selectedItemId: items.first['nome'],
    );
  }

  Future<String> _getComplexoName() async {
    List<Map<String, dynamic>> items;
    items = await complexo.listarComplexos();
    String nome = "";
    for (var item in items) {
      if (item['id'] == _reloadComplexo.value) {
        // ignore: void_checks
        nome = item['nome'];
      }
    }
    return nome;
  }
}

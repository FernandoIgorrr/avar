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

  late Complexo complexo;
  late PatrimonioListar patrimonio;

  @override
  void initState() {
    super.initState();
    complexo = Complexo();
    patrimonio = PatrimonioListar();
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
                    SizedBox(height: 15.v),
                  ]),
                ]),
            ValueListenableBuilder<String>(
                valueListenable: _reloadComplexo,
                builder: (context, value, child) {
                  return patrimonio.listarPatrimoniosWidget(
                      patrimonio.listarPatrimoniosPorComplexo(context, value));
                }),
          ]),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<Widget> _buildComplexo(BuildContext context) async {
    List<Map<String, dynamic>> items = await complexo.listarComplexos();
    return CustomDropDownMenuString(
      reloadElement: _reloadComplexo,
      descName: 'nome',
      selectedItemIdController: _complexoController,
      items: items,
      selectedItemId: items.first['nome'],
    );
  }
}

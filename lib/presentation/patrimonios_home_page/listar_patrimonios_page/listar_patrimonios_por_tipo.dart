import 'package:avar/core/app_export.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:flutter/material.dart';

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

  late TipoPatrimonio tipo;
  late PatrimonioListar patrimonio;

  @override
  void initState() {
    super.initState();

    tipo = TipoPatrimonio();
    patrimonio = PatrimonioListar();
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
                  return patrimonio.listarPatrimoniosWidget(
                      patrimonio.listarPatrimoniosPorTipo(context, value));
                }),
          ]),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<Widget> _buildTipos(BuildContext context) async {
    List<Map<String, dynamic>> items = await tipo.listarTipos();
    return CustomDropDownMenuString(
      reloadElement: _reloadTipo,
      selectedItemIdController: _tipoController,
      items: items,
      selectedItemId: items.first['descricao'],
    );
  }
}

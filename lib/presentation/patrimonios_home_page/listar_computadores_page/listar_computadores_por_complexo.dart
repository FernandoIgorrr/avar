import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarComputadoresPorComplexo extends StatefulWidget {
  const ListarComputadoresPorComplexo({Key? key}) : super(key: key);

  @override
  State<ListarComputadoresPorComplexo> createState() =>
      _ListarComputadoresPorComplexoState();
}

class _ListarComputadoresPorComplexoState
    extends State<ListarComputadoresPorComplexo> {
  late Future<List<ComputadorListar>> computadores;
  late ComputadorListar computador;
  late Complexo complexo;

  TextEditingController _complexoController = TextEditingController();

  ValueNotifier<String> _reloadComplexo = ValueNotifier<String>("CAMPUS");

  @override
  void initState() {
    super.initState();
    computador = ComputadorListar();
    complexo = Complexo();
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
                  return computador.listarComputadoresWidget(
                      computador.listarComputadoresPorComplexo(context, value));
                }),
          ]),
        ),
        bottomNavigationBar: CustomBottomBar(),
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

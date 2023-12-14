import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarComputadoresPorPredio extends StatefulWidget {
  const ListarComputadoresPorPredio({Key? key}) : super(key: key);

  @override
  State<ListarComputadoresPorPredio> createState() =>
      _ListarComputadoresPorPredioState();
}

class _ListarComputadoresPorPredioState
    extends State<ListarComputadoresPorPredio> {
  late ComputadorListar computador;
  late Complexo complexo;
  late Predio predio;

  TextEditingController _complexoController = TextEditingController();
  TextEditingController _predioController = TextEditingController();

  ValueNotifier<int> _reloadComplexo = ValueNotifier<int>(1);
  ValueNotifier<String> _reloadPredio = ValueNotifier<String>("CAMPUS I");

  @override
  void initState() {
    super.initState();
    computador = ComputadorListar();
    complexo = Complexo();
    predio = Predio();
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
                  return computador.listarComputadoresWidget(
                      computador.listarComputadoresPorPredio(context, value));
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
}

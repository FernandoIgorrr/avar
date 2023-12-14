import 'package:avar/core/app_export.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarPatrimoniosPorComodo extends StatefulWidget {
  const ListarPatrimoniosPorComodo({Key? key}) : super(key: key);

  @override
  State<ListarPatrimoniosPorComodo> createState() =>
      _ListarPatrimoniosPorComodoState();
}

class _ListarPatrimoniosPorComodoState
    extends State<ListarPatrimoniosPorComodo> {
  late Future<List<PatrimonioListar>> patrimonios;

  TextEditingController _complexoController = TextEditingController();
  TextEditingController _predioController = TextEditingController();
  TextEditingController _andarController = TextEditingController();
  TextEditingController _comodoController = TextEditingController();

  ValueNotifier<int> _reloadComplexo = ValueNotifier<int>(1);
  ValueNotifier<int> _reloadPredio = ValueNotifier<int>(1);
  ValueNotifier<int> _reloadAndar = ValueNotifier<int>(1);
  ValueNotifier<int> _reloadComodo = ValueNotifier<int>(1);

  late Complexo complexo;
  late Predio predio;
  late Andar andar;
  late Comodo comodo;

  late PatrimonioListar patrimonio;

  @override
  void initState() {
    super.initState();

    complexo = Complexo();
    predio = Predio();
    andar = Andar();
    comodo = Comodo();

    patrimonio = PatrimonioListar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_por_comodo".tr),
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
                    SizedBox(height: 12.v),
                    ValueListenableBuilder<int>(
                      valueListenable: _reloadPredio,
                      builder: (context, value, child) {
                        return FutureBuilder(
                          future: _buildAndar(context, value),
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
                    SizedBox(height: 12.v),
                    ValueListenableBuilder<int>(
                      valueListenable: _reloadAndar,
                      builder: (context, value, child) {
                        return FutureBuilder(
                          future: _buildComodo(context, value),
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
            ValueListenableBuilder<int>(
                valueListenable: _reloadComodo,
                builder: (context, value, child) {
                  return patrimonio.listarPatrimoniosWidget(
                      patrimonio.listarPatrimoniosPorComodo(
                          context,
                          _getComplexoName(),
                          _getPredioName(),
                          _getAndarName(),
                          _getComodoName()));
                }),
          ]),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<Widget> _buildComplexo(BuildContext context) async {
    List<Map<String, dynamic>> items = await complexo.listarComplexos();
    _reloadComplexo.value = items.first['id'];
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
    _reloadPredio.value = items.first['id'];
    return CustomDropDownMenu(
      reloadElement: _reloadPredio,
      descName: 'nome',
      selectedItemIdController: _predioController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildAndar(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await andar.listarAndares(value);
    _reloadAndar.value = items.first['id'];
    return CustomDropDownMenu(
      reloadElement: _reloadAndar,
      descName: 'nome',
      selectedItemIdController: _andarController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildComodo(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await comodo.listarComodos(value);
    _reloadComodo.value = items.first['id'];
    return CustomDropDownMenu(
      reloadElement: _reloadComodo,
      descName: 'nome',
      selectedItemIdController: _comodoController,
      items: items,
      selectedItemId: items.first['id'],
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

  Future<String> _getPredioName() async {
    List<Map<String, dynamic>> items;
    items = await predio.listarPredios(_reloadComplexo.value);
    String nome = "";
    for (var item in items) {
      if (item['id'] == _reloadPredio.value) {
        // ignore: void_checks
        nome = item['nome'];
      }
    }
    return nome;
  }

  Future<String> _getAndarName() async {
    List<Map<String, dynamic>> items;
    items = await andar.listarAndares(_reloadPredio.value);
    String nome = "";
    for (var item in items) {
      if (item['id'] == _reloadAndar.value) {
        // ignore: void_checks
        nome = item['nome'];
      }
    }
    return nome;
  }

  Future<String> _getComodoName() async {
    List<Map<String, dynamic>> items;
    items = await comodo.listarComodos(_reloadAndar.value);
    String nome = "";
    for (var item in items) {
      if (item['id'] == _reloadComodo.value) {
        // ignore: void_checks
        nome = item['nome'];
      }
    }
    return nome;
  }
}

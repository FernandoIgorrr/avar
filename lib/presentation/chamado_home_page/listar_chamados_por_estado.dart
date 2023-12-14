import 'package:avar/core/app_export.dart';
import 'package:avar/domain/chamado.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarChamadosPorEstado extends StatefulWidget {
  const ListarChamadosPorEstado({Key? key}) : super(key: key);

  @override
  State<ListarChamadosPorEstado> createState() =>
      _ListarChamadosPorEstadoState();
}

class _ListarChamadosPorEstadoState extends State<ListarChamadosPorEstado> {
  TextEditingController _estadoController = TextEditingController();

  ValueNotifier<String> _reloadEstado = ValueNotifier<String>("Aberto");

  late ChamadoListar chamado;
  late EstadoChamado estado;

  @override
  void initState() {
    super.initState();
    chamado = ChamadoListar();
    estado = EstadoChamado();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_por_estado".tr),
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
                  child: Text("lbl_estado".tr),
                ),
                children: [
                  Column(children: [
                    SizedBox(height: 15.v),
                    FutureBuilder<Widget>(
                      future: _buildEstados(context),
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
                valueListenable: _reloadEstado,
                builder: (context, value, child) {
                  return chamado.listarChamadosWidget(
                      chamado.listarChamadosPorEstado(context, value));
                }),
          ]),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<Widget> _buildEstados(BuildContext context) async {
    List<Map<String, dynamic>> items = await estado.listarEstados();
    return CustomDropDownMenuString(
      reloadElement: _reloadEstado,
      selectedItemIdController: _estadoController,
      items: items,
      selectedItemId: items.first['descricao'],
    );
  }
}

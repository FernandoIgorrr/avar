import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarComputadoresTudo extends StatefulWidget {
  const ListarComputadoresTudo({Key? key}) : super(key: key);

  @override
  State<ListarComputadoresTudo> createState() => _ListarComputadoresTudoState();
}

class _ListarComputadoresTudoState extends State<ListarComputadoresTudo> {
  late ComputadorListar computador;

  @override
  void initState() {
    super.initState();
    computador = ComputadorListar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_pc_tudo".tr),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(
                height: 15.v,
              ),
              computador.listarComputadoresWidget(
                  computador.listarComputadoresTudo(context)),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}

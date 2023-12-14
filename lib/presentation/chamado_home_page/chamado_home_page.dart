import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ChamadosHomePage extends StatelessWidget {
  const ChamadosHomePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: 'lbl_chamados'.tr),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonIcon(
                    text: "lbl_cadastrar".tr,
                    routeName: AppRoutes.cadastrarChamado,
                  ),
                  ButtonIcon(
                    text: "lbl_listar".tr,
                    routeName: AppRoutes.listarChamadosTudo,
                  ),
                  ButtonIcon(
                    text: "lbl_listar_por_estado".tr,
                    routeName: AppRoutes.listarChamadosPorEstado,
                  ),
                ],
              ),
            ],
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }
}

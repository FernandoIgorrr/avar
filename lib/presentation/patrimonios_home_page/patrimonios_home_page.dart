import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class PatrimoniosHomePage extends StatelessWidget {
  const PatrimoniosHomePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: 'lbl_patrimonios'.tr),
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
                    routeName: AppRoutes.cadastrarPatrimonio,
                  ),
                  ButtonIcon(
                    text: "lbl_listar".tr,
                    routeName: AppRoutes.listarPatrimoniosHomePage,
                  ),
                  ButtonIcon(
                    text: "lbl_cadastrar_computador".tr,
                    routeName: AppRoutes.cadastrarComputador,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonIcon(
                    text: "lbl_listar_computadores".tr,
                    routeName: AppRoutes.listarComputadoresHomePage,
                  ),
                  ButtonIcon(
                    text: "lbl_alienamentos".tr,
                    routeName: AppRoutes.listarAlienamentosTudo,
                  ),
                  ButtonIcon(
                    text: "lbl_manejos".tr,
                    routeName: AppRoutes.listarManejosTudo,
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

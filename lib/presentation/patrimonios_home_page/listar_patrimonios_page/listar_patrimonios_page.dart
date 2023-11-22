import 'package:avar/core/app_export.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarPatrimoniosPage extends StatelessWidget {
  const ListarPatrimoniosPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_patrimonios".tr),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(height: 25.adaptSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonIcon(
                      text: "lbl_listar_tudo".tr,
                      routeName: AppRoutes.listarPatrimoniosTudo),
                  ButtonIcon(text: "lbl_listar_por_complexo".tr),
                  ButtonIcon(text: "lbl_listar_por_predio".tr),
                ],
              ),
              SizedBox(height: 25.adaptSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonIcon(text: "lbl_listar_por_andar".tr),
                  ButtonIcon(text: "lbl_listar_por_comodo".tr),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}

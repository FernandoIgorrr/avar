import 'package:avar/core/app_export.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class BolsistaPage extends StatelessWidget {
  const BolsistaPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: 'lbl_bolsistas'.tr),
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
                    routeName: AppRoutes.cadastrarBolsista,
                  ),
                  ButtonIcon(
                    text: "lbl_listar".tr,
                    routeName: AppRoutes.bolsistaListarPage,
                  ),
                  ButtonIcon(
                    text: "lbl_desligar_bolsista".tr,
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

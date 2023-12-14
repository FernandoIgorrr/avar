import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class BolsistaListarPage extends StatelessWidget {
  const BolsistaListarPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: 'lbl_listar_bolsistas'.tr),
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
                    text: "lbl_listar_todos".tr,
                    routeName: AppRoutes.bolsistaListarTudo,
                  ),
                  ButtonIcon(
                    text: "lbl_listar_ativos".tr,
                    routeName: AppRoutes.bolsistaListarTudo,
                  ),
                  ButtonIcon(
                    text: "lbl_listar_desligados".tr,
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

import 'package:avar/core/app_export.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class BolsistaHomePage extends StatelessWidget {
  const BolsistaHomePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(
        //   title: AppbarTitle(text: 'lbl_home'.tr),
        // ),
        appBar: CustomAppBar(
            automaticallyImplyLeading: false,
            title: AppbarTitle(
              text: "lbl_home".tr,
            )),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              const SizedBox(height: 25), // Espaço vertical entre linhas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonIcon(
                      text: "lbl_patrimonios".tr,
                      routeName: AppRoutes.patrimoniosHomePage),
                  ButtonIcon(
                    text: "lbl_chamados".tr,
                    routeName: AppRoutes.chamadoHomePage,
                  ),
                  ButtonIcon(text: "lbl_tarefas".tr),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }
}

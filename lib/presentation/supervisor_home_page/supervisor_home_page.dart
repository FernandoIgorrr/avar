import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: 'Home'),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              const SizedBox(height: 20), // Espaço vertical entre linhas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonIcon(),
                  ButtonIcon(),
                  ButtonIcon(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileSection(BuildContext co, ntext) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100.adaptSize,
          width: 100.adaptSize,
          padding: EdgeInsets.symmetric(
            horizontal: 17.h,
            vertical: 10.v,
          ),
          decoration: AppDecoration.fillBlueGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgProfile,
            height: 77.v,
            width: 63.h,
            alignment: Alignment.center,
          ),
        ),
        Container(
          height: 100.adaptSize,
          width: 100.adaptSize,
          padding: EdgeInsets.symmetric(
            horizontal: 17.h,
            vertical: 10.v,
          ),
          decoration: AppDecoration.fillBlueGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgProfile,
            height: 77.v,
            width: 63.h,
            alignment: Alignment.center,
          ),
        ),
        Container(
          height: 100.adaptSize,
          width: 100.adaptSize,
          padding: EdgeInsets.symmetric(
            horizontal: 17.h,
            vertical: 10.v,
          ),
          decoration: AppDecoration.fillBlueGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgProfile,
            height: 77.v,
            width: 63.h,
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPatrimNiosSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.h,
        right: 20.h,
      ),
      child: Row(
        children: [
          Text(
            "lbl_patrim_nios".tr,
            style: theme.textTheme.titleMedium,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.h),
            child: Text(
              "lbl_chamados".tr,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Spacer(),
          Text(
            "lbl_tarefas".tr,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

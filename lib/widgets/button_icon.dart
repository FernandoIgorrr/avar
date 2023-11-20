import 'package:avar/theme/app_decoration.dart';
import 'package:avar/theme/theme_helper.dart';
import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  ButtonIcon({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.adaptSize,
      width: 100.adaptSize,
      margin: EdgeInsets.only(left: 14.h),
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
    );
  }
}

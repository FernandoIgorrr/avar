import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  ButtonIcon({
    Key? key,
    this.text,
    this.imagePath,
    this.routeName,
  }) : super(
          key: key,
        );

  final String? text;
  final String? imagePath;
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context)
              .pushNamed(routeName ?? AppRoutes.supervisorHomePage)
        },
        child: Column(children: [
          Container(
            height: 100.adaptSize,
            width: 100.adaptSize,
            //margin: EdgeInsets.only(left: 14.h),
            padding: EdgeInsets.symmetric(
              horizontal: 17.h,
              vertical: 10.v,
            ),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: CustomImageView(
              imagePath: imagePath ?? ImageConstant.imgProfile,
              height: 80.v,
              width: 70.h,
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            // height: 0.adaptSize,
            width: 100,
            height: 25,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text ?? 'Padrao',
                style: theme.textTheme.titleMedium!
                    .copyWith(color: appTheme.blueGray100),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ]),
      ),
    );
  }
}

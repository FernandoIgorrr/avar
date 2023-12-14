import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.title,
    this.height,
    this.styleType,
    this.automaticallyImplyLeading,
    this.centerTitle,
  }) : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  // final double? leadingWidth;

  //final Widget? leading;

  final bool? automaticallyImplyLeading;

  final Widget? title;

  final bool? centerTitle;

  //final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      elevation: 0,
      toolbarHeight: height ?? 60.v,
      backgroundColor: appTheme.purple500,
      flexibleSpace: _getStyle(),
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? true,
      iconTheme: IconThemeData(color: appTheme.blueGray100, size: 35.adaptSize),
    );
  }

  @override
  Size get preferredSize => Size(
        mediaQueryData.size.width,
        height ?? 60.v,
      );

  _getStyle() {
    switch (styleType) {
      case Style.bgFill:
        return Container(
          height: 60.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.purple500,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFill,
}

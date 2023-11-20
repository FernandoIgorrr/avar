import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    Key? key,
    required this.text,
  }) : super(
          key: key,
        );

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.blueGray100,
      ),
    );
  }
}

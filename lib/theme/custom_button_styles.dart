import 'dart:ui';
import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillPrimaryContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );
  static ButtonStyle get fillRedAccentBotLeft => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.error,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.h)),
        ),
      );
  static ButtonStyle get fillGreenLightBotRight => ElevatedButton.styleFrom(
        backgroundColor: appTheme.greenLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.h)),
        ),
      );
  static ButtonStyle get fillPrimarySquare => ElevatedButton.styleFrom(
        backgroundColor: appTheme.purple500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(0.h)),
        ),
      );

  static ButtonStyle get fillPurple => ElevatedButton.styleFrom(
        backgroundColor: appTheme.purple500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
      );
  static ButtonStyle get fillPurple1 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.purple500,
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}

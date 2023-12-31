import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Headline text style
  static get headlineSmallOnPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );

  static get titleLargeBlack900Opa => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900opacity,
      );

  static get titleLargeOnPrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static get titleSmallOnblueGray100 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray100,
      );

  static get titleMediumOnblueGray100 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray100,
      );

  static get titleLargeOnblueGray100 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.blueGray100,
      );

  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}

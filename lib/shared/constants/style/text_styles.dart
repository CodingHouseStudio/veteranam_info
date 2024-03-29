import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KAppTextStyle {
  /// fontFamily: none
  /// fontSize: 16px
  /// height: none
  /// fontWeight: none
  /// letterSpacing: none
  /// fontStyle: none
  /// decoration: none
  /// FontStyle: normal
  static const TextStyle inputHintTextStyle = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontM,
    fontStyle: FontStyle.normal,
  );

  static const title = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const lableLarge = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontL,
    fontWeight: FontWeight.w400,
  );

  static const lableMediumLarge = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontML,
    fontWeight: FontWeight.w400,
  );

  static const lableMedium = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const lableMediumSmall = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );
}

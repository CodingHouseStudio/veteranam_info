import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KAppTextStyle {
  /// m3BodyMedium figma properties
  /// fontFamily: Roboto
  /// fontSize: 14px
  /// height: 20px
  /// fontWeight: 400
  /// letterSpacing: 0.25px
  /// fontStyle: none
  /// decoration: none
  static const TextStyle m3BodyMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: KSize.kFontSizeM,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

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
    fontSize: KSize.kFontSizeML,
    fontStyle: FontStyle.normal,
  );

  static const title = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontSizeML,
    fontWeight: FontWeight.w400,
  );

  static const subTitle = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontSizeM,
    fontWeight: FontWeight.w400,
  );
}

import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KAppTextStyle {
  static const title = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const titleSmall = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontXS,
    fontWeight: FontWeight.w400,
  );

  static const titleMediumSmall = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontS,
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
    fontSize: KSize.kFontSM,
    fontWeight: FontWeight.w400,
  );

  static const lableSmall = TextStyle(
    color: KColorTheme.black,
    fontSize: KSize.kFontSSM,
    fontWeight: FontWeight.w400,
  );

  static const hint = TextStyle(
    color: KColorTheme.lightGray,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );
}

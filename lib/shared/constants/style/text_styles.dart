import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class KAppTextStyle {
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

  static const hint = TextStyle(
    color: KColorTheme.lightGray,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );
}

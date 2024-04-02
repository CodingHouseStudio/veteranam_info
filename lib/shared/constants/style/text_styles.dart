import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class AppTextStyle {
  static const titleMediumLarge = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: KSize.kFontML,
    fontWeight: FontWeight.w400,
  );
  static const title = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const titleSmall = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontXS,
    fontWeight: FontWeight.w400,
  );

  static const titleMediumSmall = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontS,
    fontWeight: FontWeight.w400,
  );

  static const lableLarge = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontL,
    fontWeight: FontWeight.w400,
  );

  static const lableMediumLarge = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontML,
    fontWeight: FontWeight.w400,
  );

  static const lableMedium = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const lableMediumSmall = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontSSM,
    fontWeight: FontWeight.w400,
  );

  static const lableSmall = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontS,
  );

  static const lableXS = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontXS,
  );

  static const hint = TextStyle(
    color: AppColors.lightGray,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );
}

import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class AppTextStyle {
  static const title = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontM,
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
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const hint = TextStyle(
    color: AppColors.lightGray,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );
}

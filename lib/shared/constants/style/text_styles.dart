import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

abstract class AppTextStyle {
  static const titleML = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: KSize.kFontML,
    fontWeight: FontWeight.w400,
  );
  static const titleM = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const titleXS = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontXS,
    fontWeight: FontWeight.w400,
  );

  static const titleS = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontS,
    fontWeight: FontWeight.w400,
  );

  static const lableL = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontL,
    fontWeight: FontWeight.w400,
  );

  static const lableML = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontML,
    fontWeight: FontWeight.w400,
  );

  static const lableM = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );

  static const lableSM = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontSM,
    fontWeight: FontWeight.w400,
  );

  static const lableSSM = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontSSM,
    fontWeight: FontWeight.w400,
  );

  static const lableS = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontS,
  );

  static const lableXS = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFontXS,
  );

  static const hintM = TextStyle(
    color: AppColors.lightGray,
    fontSize: KSize.kFontM,
    fontWeight: FontWeight.w400,
  );
}

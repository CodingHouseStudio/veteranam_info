import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

/// Text Styles

abstract class AppTextStyle {
  static const text128 = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: KSize.kFont128,
    fontWeight: FontWeight.w400,
  );

  static const text96 = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: KSize.kFont96,
    fontWeight: FontWeight.w400,
  );

  static const text64 = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: KSize.kFont64,
    fontWeight: FontWeight.w400,
  );

  static const text48 = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: KSize.kFont48,
    fontWeight: FontWeight.w400,
  );

  static const text40 = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: KSize.kFont40,
    fontWeight: FontWeight.w400,
  );

  static const text32 = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFont32,
    fontWeight: FontWeight.w400,
  );

  static const text24 = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFont24,
    fontWeight: FontWeight.w400,
  );

  static const text20 = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFont20,
    fontWeight: FontWeight.w400,
  );

  static const text18 = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFont18,
    fontWeight: FontWeight.w400,
  );

  static const text16 = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFont16,
  );

  static const text14 = TextStyle(
    color: AppColors.black,
    fontSize: KSize.kFont14,
  );

  static const hint24 = TextStyle(
    color: AppColors.lightGray,
    fontSize: KSize.kFont24,
    fontWeight: FontWeight.w400,
  );

  static const hint16 = TextStyle(
    color: AppColors.lightGray,
    fontSize: KSize.kFont16,
    fontWeight: FontWeight.w400,
  );

  static const hint14 = TextStyle(
    color: AppColors.grey,
    fontSize: KSize.kFont14,
    fontWeight: FontWeight.w400,
  );
}

import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

ThemeData themeData = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppColors.materialThemeKeyColorsSecondary,
    secondary: AppColors.materialThemeWhite,
    surface: AppColors.materialThemeWhite,
    // background: AppColors.materialThemeWhite,
    error: AppColors.materialThemeRefErrorError50,
    onPrimary: AppColors.materialThemeWhite,
    onSecondary: AppColors.materialThemeWhite,
    onSurface: AppColors.materialThemeKeyColorsSecondary,
    // onBackground: AppColors.materialThemeKeyColorsSecondary,
    onError: AppColors.materialThemeWhite,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: AppColors.materialThemeKeyColorsNeutralVariant,
    elevation: 0,
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
      foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
      overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
    ),
  ),
  useMaterial3: true,
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: AppColors.materialThemeWhite,
    ),
  ),
);

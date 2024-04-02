import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

ThemeData themeData = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppColors.black,
    secondary: AppColors.white,
    surface: AppColors.white,
    background: AppColors.background,
    error: AppColors.error,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.black,
    onBackground: AppColors.grey,
    onError: AppColors.white,
    brightness: Brightness.light,
  ),
  dividerColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    titleTextStyle: AppTextStyle.lableM,
    backgroundColor: AppColors.background,
    elevation: 0,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
    ),
  ),
  useMaterial3: true,
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: AppColors.background,
    ),
  ),
  textTheme: const TextTheme(
      // displayLarge: AppTextStyle.m3TitleLarge,
      // displayMedium: AppTextStyle.m3TitleMedium,
      // displaySmall: AppTextStyle.m3TitleSmall,
      // titleLarge: AppTextStyle.m3TitleLarge,
      // bodyLarge: AppTextStyle.m3BodyLarge,
      // bodyMedium: AppTextStyle.m3BodyMedium,
      // labelLarge: AppTextStyle.m3LabelLarge,
      // labelMedium: AppTextStyle.m3LabelMedium,
      // titleMedium: AppTextStyle.m3TitleMedium,
      ),
);

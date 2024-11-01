import 'package:flutter/material.dart'
    show
        AppBarTheme,
        BottomNavigationBarThemeData,
        Brightness,
        ButtonStyle,
        ButtonThemeData,
        Color,
        ColorScheme,
        Colors,
        IconButtonThemeData,
        MouseCursor,
        SystemMouseCursors,
        TextButtonThemeData,
        TextTheme,
        ThemeData,
        TooltipThemeData,
        WidgetState,
        WidgetStateProperty,
        WidgetStatePropertyAll;
import 'package:veteranam/shared/constants/constants_flutter.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';

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
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.materialThemeKeyColorsSecondary,
    unselectedItemColor: AppColors.materialThemeKeyColorsSecondary,
  ),
  tooltipTheme: const TooltipThemeData(
    preferBelow: false,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: AppColors.materialThemeKeyColorsNeutralVariant,
    elevation: 0,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      mouseCursor: WidgetStatePropertyExtension.buttonMouseCursor,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
      foregroundColor: const WidgetStatePropertyAll<Color>(
        AppColors.materialThemeKeyColorsSecondary,
      ),
      overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
      mouseCursor: WidgetStatePropertyExtension.buttonMouseCursor,
    ),
  ),
  textTheme: const TextTheme()
    ..apply(
      bodyColor: AppColors.materialThemeKeyColorsSecondary,
      displayColor: AppColors.materialThemeKeyColorsSecondary,
    ),
  useMaterial3: true,
  buttonTheme: ButtonThemeData(
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: AppColors.materialThemeWhite,
    ),
  ),
);

// WidgetStateProperty<MouseCursor?> get _buttonMouseCursor =>
//     WidgetStateProperty.resolveWith((states) {
//       if (states.contains(WidgetState.disabled)) {
//         return SystemMouseCursors.forbidden;
//       }
//       return SystemMouseCursors.click;
//     });

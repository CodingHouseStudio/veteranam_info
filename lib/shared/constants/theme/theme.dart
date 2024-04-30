import 'package:flutter/material.dart';

class MaterialTheme {
  const MaterialTheme(this.textTheme);
  final TextTheme textTheme;

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff4f6629),
      onPrimary: Color(0xffD9D9D9),
      primaryContainer: Color(0xffE6E6E6),
      onPrimaryContainer: Color(0xff121f00),
      secondary: Color(0xff596248),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffFFF623),
      onSecondaryContainer: Color(0xff171e0a),
      tertiary: Color(0xff396661),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcece5),
      onTertiaryContainer: Color(0xff00201d),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xffffffff),
      onBackground: Color(0xff1a1c15),
      surface: Color(0xfffafaee),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffe2e4d4),
      onSurfaceVariant: Color(0xff45483d),
      outline: Color(0xffD9D9D9),
      outlineVariant: Color(0xffc5c8b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inverseOnSurface: Color(0xfff1f2e6),
      inversePrimary: Color(0xffb5d087),
      primaryFixed: Color(0xffd1eca0),
      onPrimaryFixed: Color(0xff121f00),
      primaryFixedDim: Color(0xffb5d087),
      onPrimaryFixedVariant: Color(0xff384d13),
      secondaryFixed: Color(0xffdde6c6),
      onSecondaryFixed: Color(0xff171e0a),
      secondaryFixedDim: Color(0xffc1caab),
      onSecondaryFixedVariant: Color(0xff414a32),
      tertiaryFixed: Color(0xffbcece5),
      onTertiaryFixed: Color(0xff00201d),
      tertiaryFixedDim: Color(0xffa0d0c9),
      onTertiaryFixedVariant: Color(0xff1f4e4a),
      surfaceDim: Color(0xffdadbcf),
      surfaceBright: Color(0xfffafaee),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f4e9),
      surfaceContainer: Color(0xffeeefe3),
      surfaceContainerHigh: Color(0xffe8e9dd),
      surfaceContainerHighest: Color(0xffe3e3d8),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff34490f),
      surfaceTint: Color(0xff4f6629),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff647c3d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3d462e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6f785d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1b4a46),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f7d77),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffafaee),
      onBackground: Color(0xff1a1c15),
      surface: Color(0xfffafaee),
      onSurface: Color(0xff1a1c15),
      surfaceVariant: Color(0xffe2e4d4),
      onSurfaceVariant: Color(0xff414439),
      outline: Color(0xff5d6054),
      outlineVariant: Color(0xff797c6f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inverseOnSurface: Color(0xfff1f2e6),
      inversePrimary: Color(0xffb5d087),
      primaryFixed: Color(0xff647c3d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff4c6326),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6f785d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff565f46),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f7d77),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff36645f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdadbcf),
      surfaceBright: Color(0xfffafaee),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f4e9),
      surfaceContainer: Color(0xffeeefe3),
      surfaceContainerHigh: Color(0xffe8e9dd),
      surfaceContainerHighest: Color(0xffe3e3d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff182700),
      surfaceTint: Color(0xff4f6629),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff34490f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1d2510),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3d462e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002724),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1b4a46),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffafaee),
      onBackground: Color(0xff1a1c15),
      surface: Color(0xfffafaee),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffe2e4d4),
      onSurfaceVariant: Color(0xff22251b),
      outline: Color(0xff414439),
      outlineVariant: Color(0xff414439),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f312a),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffdaf6a9),
      primaryFixed: Color(0xff34490f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff203200),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3d462e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff272f1a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1b4a46),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00332f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdadbcf),
      surfaceBright: Color(0xfffafaee),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f4e9),
      surfaceContainer: Color(0xffeeefe3),
      surfaceContainerHigh: Color(0xffe8e9dd),
      surfaceContainerHighest: Color(0xffe3e3d8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb5d087),
      surfaceTint: Color(0xffb5d087),
      onPrimary: Color(0xff233600),
      primaryContainer: Color(0xff384d13),
      onPrimaryContainer: Color(0xffd1eca0),
      secondary: Color(0xffc1caab),
      onSecondary: Color(0xff2b331d),
      secondaryContainer: Color(0xff414a32),
      onSecondaryContainer: Color(0xffdde6c6),
      tertiary: Color(0xffa0d0c9),
      onTertiary: Color(0xff013733),
      tertiaryContainer: Color(0xff1f4e4a),
      onTertiaryContainer: Color(0xffbcece5),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff12140e),
      onBackground: Color(0xffe3e3d8),
      surface: Color(0xff12140e),
      onSurface: Color(0xffe3e3d8),
      surfaceVariant: Color(0xff45483d),
      onSurfaceVariant: Color(0xffc5c8b9),
      outline: Color(0xff8f9285),
      outlineVariant: Color(0xff45483d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e3d8),
      inverseOnSurface: Color(0xff2f312a),
      inversePrimary: Color(0xff4f6629),
      primaryFixed: Color(0xffd1eca0),
      onPrimaryFixed: Color(0xff121f00),
      primaryFixedDim: Color(0xffb5d087),
      onPrimaryFixedVariant: Color(0xff384d13),
      secondaryFixed: Color(0xffdde6c6),
      onSecondaryFixed: Color(0xff171e0a),
      secondaryFixedDim: Color(0xffc1caab),
      onSecondaryFixedVariant: Color(0xff414a32),
      tertiaryFixed: Color(0xffbcece5),
      onTertiaryFixed: Color(0xff00201d),
      tertiaryFixedDim: Color(0xffa0d0c9),
      onTertiaryFixedVariant: Color(0xff1f4e4a),
      surfaceDim: Color(0xff12140e),
      surfaceBright: Color(0xff383a32),
      surfaceContainerLowest: Color(0xff0d0f09),
      surfaceContainerLow: Color(0xff1a1c15),
      surfaceContainer: Color(0xff1e2019),
      surfaceContainerHigh: Color(0xff292b23),
      surfaceContainerHighest: Color(0xff33362e),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb9d48a),
      surfaceTint: Color(0xffb5d087),
      onPrimary: Color(0xff0e1a00),
      primaryContainer: Color(0xff809956),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc5cfaf),
      onSecondary: Color(0xff111906),
      secondaryContainer: Color(0xff8b9478),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa4d4ce),
      onTertiary: Color(0xff001a18),
      tertiaryContainer: Color(0xff6b9994),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff12140e),
      onBackground: Color(0xffe3e3d8),
      surface: Color(0xff12140e),
      onSurface: Color(0xfffbfcf0),
      surfaceVariant: Color(0xff45483d),
      onSurfaceVariant: Color(0xffcaccbd),
      outline: Color(0xffa1a496),
      outlineVariant: Color(0xff818577),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e3d8),
      inverseOnSurface: Color(0xff292b23),
      inversePrimary: Color(0xff394f14),
      primaryFixed: Color(0xffd1eca0),
      onPrimaryFixed: Color(0xff0a1400),
      primaryFixedDim: Color(0xffb5d087),
      onPrimaryFixedVariant: Color(0xff283c02),
      secondaryFixed: Color(0xffdde6c6),
      onSecondaryFixed: Color(0xff0c1303),
      secondaryFixedDim: Color(0xffc1caab),
      onSecondaryFixedVariant: Color(0xff313923),
      tertiaryFixed: Color(0xffbcece5),
      onTertiaryFixed: Color(0xff001412),
      tertiaryFixedDim: Color(0xffa0d0c9),
      onTertiaryFixedVariant: Color(0xff093d39),
      surfaceDim: Color(0xff12140e),
      surfaceBright: Color(0xff383a32),
      surfaceContainerLowest: Color(0xff0d0f09),
      surfaceContainerLow: Color(0xff1a1c15),
      surfaceContainer: Color(0xff1e2019),
      surfaceContainerHigh: Color(0xff292b23),
      surfaceContainerHighest: Color(0xff33362e),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5ffdc),
      surfaceTint: Color(0xffb5d087),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb9d48a),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff5ffde),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc5cfaf),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffebfffb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa4d4ce),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff12140e),
      onBackground: Color(0xffe3e3d8),
      surface: Color(0xff12140e),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff45483d),
      onSurfaceVariant: Color(0xfffafcec),
      outline: Color(0xffcaccbd),
      outlineVariant: Color(0xffcaccbd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e3d8),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff1e2f00),
      primaryFixed: Color(0xffd5f1a4),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb9d48a),
      onPrimaryFixedVariant: Color(0xff0e1a00),
      secondaryFixed: Color(0xffe1ebca),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc5cfaf),
      onSecondaryFixedVariant: Color(0xff111906),
      tertiaryFixed: Color(0xffc0f0ea),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa4d4ce),
      onTertiaryFixedVariant: Color(0xff001a18),
      surfaceDim: Color(0xff12140e),
      surfaceBright: Color(0xff383a32),
      surfaceContainerLowest: Color(0xff0d0f09),
      surfaceContainerLow: Color(0xff1a1c15),
      surfaceContainer: Color(0xff1e2019),
      surfaceContainerHigh: Color(0xff292b23),
      surfaceContainerHighest: Color(0xff33362e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
  final Color seed;
  final Color value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

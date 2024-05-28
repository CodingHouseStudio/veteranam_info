import 'package:flutter/material.dart';

class MaterialTheme {
  const MaterialTheme(this.textTheme);
  final TextTheme textTheme;

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff59641f),
      surfaceTint: Color(0xff59641f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffddea96),
      onPrimaryContainer: Color(0xff191e00),
      secondary: Color(0xff59641f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffddea96),
      onSecondaryContainer: Color(0xff191e00),
      tertiary: Color(0xff006874),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9eeffd),
      onTertiaryContainer: Color(0xff001f24),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xffffffff),
      onBackground: Color(0xff1b1c15),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff171d1b),
      surfaceVariant: Color(0xffe1e4d5),
      onSurfaceVariant: Color(0xff45483d),
      outline: Color(0xff75786c),
      outlineVariant: Color(0xffc5c8b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3230),
      inverseOnSurface: Color(0xffecf2ee),
      inversePrimary: Color(0xffc1cd7d),
      primaryFixed: Color(0xffddea96),
      onPrimaryFixed: Color(0xff191e00),
      primaryFixedDim: Color(0xffc1cd7d),
      onPrimaryFixedVariant: Color(0xff424b07),
      secondaryFixed: Color(0xffddea96),
      onSecondaryFixed: Color(0xff191e00),
      secondaryFixedDim: Color(0xffc1cd7d),
      onSecondaryFixedVariant: Color(0xff424b07),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff004f58),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efec),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff3e4703),
      surfaceTint: Color(0xff59641f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6f7a34),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3e4703),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6f7a34),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff004a53),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff25808c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffbfaed),
      onBackground: Color(0xff1b1c15),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff171d1b),
      surfaceVariant: Color(0xffe1e4d5),
      onSurfaceVariant: Color(0xff414439),
      outline: Color(0xff5d6054),
      outlineVariant: Color(0xff797c6f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3230),
      inverseOnSurface: Color(0xffecf2ee),
      inversePrimary: Color(0xffc1cd7d),
      primaryFixed: Color(0xff6f7a34),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff57611d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6f7a34),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff57611d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff25808c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff006671),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efec),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff1f2500),
      surfaceTint: Color(0xff59641f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3e4703),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1f2500),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3e4703),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00272c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004a53),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffbfaed),
      onBackground: Color(0xff1b1c15),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffe1e4d5),
      onSurfaceVariant: Color(0xff22251b),
      outline: Color(0xff414439),
      outlineVariant: Color(0xff414439),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3230),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffe7f39f),
      primaryFixed: Color(0xff3e4703),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff293000),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3e4703),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff293000),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004a53),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003238),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efec),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc1cd7d),
      surfaceTint: Color(0xffc1cd7d),
      onPrimary: Color(0xff2c3400),
      primaryContainer: Color(0xff424b07),
      onPrimaryContainer: Color(0xffddea96),
      secondary: Color(0xffc1cd7d),
      onSecondary: Color(0xff2c3400),
      secondaryContainer: Color(0xff424b07),
      onSecondaryContainer: Color(0xffddea96),
      tertiary: Color(0xff82d3e0),
      onTertiary: Color(0xff00363d),
      tertiaryContainer: Color(0xff004f58),
      onTertiaryContainer: Color(0xff9eeffd),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff13140d),
      onBackground: Color(0xffe4e3d6),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffdee4e0),
      surfaceVariant: Color(0xff45483d),
      onSurfaceVariant: Color(0xffc5c8b9),
      outline: Color(0xff8f9285),
      outlineVariant: Color(0xff45483d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff2b3230),
      inversePrimary: Color(0xff59641f),
      primaryFixed: Color(0xffddea96),
      onPrimaryFixed: Color(0xff191e00),
      primaryFixedDim: Color(0xffc1cd7d),
      onPrimaryFixedVariant: Color(0xff424b07),
      secondaryFixed: Color(0xffddea96),
      onSecondaryFixed: Color(0xff191e00),
      secondaryFixedDim: Color(0xffc1cd7d),
      onSecondaryFixedVariant: Color(0xff424b07),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff004f58),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc5d281),
      surfaceTint: Color(0xffc1cd7d),
      onPrimary: Color(0xff141800),
      primaryContainer: Color(0xff8b974d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc5d281),
      onSecondary: Color(0xff141800),
      secondaryContainer: Color(0xff8b974d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff86d7e5),
      onTertiary: Color(0xff001a1d),
      tertiaryContainer: Color(0xff499ca9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff13140d),
      onBackground: Color(0xffe4e3d6),
      surface: Color(0xff0e1513),
      onSurface: Color(0xfff6fcf8),
      surfaceVariant: Color(0xff45483d),
      onSurfaceVariant: Color(0xffc9ccbd),
      outline: Color(0xffa1a496),
      outlineVariant: Color(0xff818578),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff252b29),
      inversePrimary: Color(0xff434d08),
      primaryFixed: Color(0xffddea96),
      onPrimaryFixed: Color(0xff0f1300),
      primaryFixedDim: Color(0xffc1cd7d),
      onPrimaryFixedVariant: Color(0xff323a00),
      secondaryFixed: Color(0xffddea96),
      onSecondaryFixed: Color(0xff0f1300),
      secondaryFixedDim: Color(0xffc1cd7d),
      onSecondaryFixedVariant: Color(0xff323a00),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff003c44),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff9ffcd),
      surfaceTint: Color(0xffc1cd7d),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc5d281),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff9ffce),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc5d281),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff1fdff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff86d7e5),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff13140d),
      onBackground: Color(0xffe4e3d6),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff45483d),
      onSurfaceVariant: Color(0xfffafcec),
      outline: Color(0xffc9ccbd),
      outlineVariant: Color(0xffc9ccbd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff262d00),
      primaryFixed: Color(0xffe1ee9a),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc5d281),
      onPrimaryFixedVariant: Color(0xff141800),
      secondaryFixed: Color(0xffe1ee9a),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc5d281),
      onSecondaryFixedVariant: Color(0xff141800),
      tertiaryFixed: Color(0xffaaf3ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff86d7e5),
      onTertiaryFixedVariant: Color(0xff001a1d),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
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

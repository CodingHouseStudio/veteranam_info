import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4283393577),
      surfaceTint: Color(4283393577),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4291947680),
      onPrimaryContainer: Color(4279377664),
      secondary: Color(4284047944),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292732614),
      onSecondaryContainer: Color(4279705098),
      tertiary: Color(4281951841),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4290571493),
      onTertiaryContainer: Color(4278198301),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294638318),
      onBackground: Color(4279901205),
      surface: Color(4294638318),
      onSurface: Color(4279901205),
      surfaceVariant: Color(4293059796),
      onSurfaceVariant: Color(4282730557),
      outline: Color(4285888620),
      outlineVariant: Color(4291152057),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282858),
      inverseOnSurface: Color(4294046438),
      inversePrimary: Color(4290105479),
      primaryFixed: Color(4291947680),
      onPrimaryFixed: Color(4279377664),
      primaryFixedDim: Color(4290105479),
      onPrimaryFixedVariant: Color(4281879827),
      secondaryFixed: Color(4292732614),
      onSecondaryFixed: Color(4279705098),
      secondaryFixedDim: Color(4290890411),
      onSecondaryFixedVariant: Color(4282468914),
      tertiaryFixed: Color(4290571493),
      onTertiaryFixed: Color(4278198301),
      tertiaryFixedDim: Color(4288729289),
      onTertiaryFixedVariant: Color(4280241738),
      surfaceDim: Color(4292533199),
      surfaceBright: Color(4294638318),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243561),
      surfaceContainer: Color(4293849059),
      surfaceContainerHigh: Color(4293454301),
      surfaceContainerHighest: Color(4293125080),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4281616655),
      surfaceTint: Color(4283393577),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284775485),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282205742),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285495389),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279978566),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283399543),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294638318),
      onBackground: Color(4279901205),
      surface: Color(4294638318),
      onSurface: Color(4279901205),
      surfaceVariant: Color(4293059796),
      onSurfaceVariant: Color(4282467385),
      outline: Color(4284309588),
      outlineVariant: Color(4286151791),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282858),
      inverseOnSurface: Color(4294046438),
      inversePrimary: Color(4290105479),
      primaryFixed: Color(4284775485),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283196198),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285495389),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283850566),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283399543),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281754719),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292533199),
      surfaceBright: Color(4294638318),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243561),
      surfaceContainer: Color(4293849059),
      surfaceContainerHigh: Color(4293454301),
      surfaceContainerHighest: Color(4293125080),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4279772928),
      surfaceTint: Color(4283393577),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281616655),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280100112),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282205742),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200100),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4279978566),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294638318),
      onBackground: Color(4279901205),
      surface: Color(4294638318),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293059796),
      onSurfaceVariant: Color(4280427803),
      outline: Color(4282467385),
      outlineVariant: Color(4282467385),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282858),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4292540073),
      primaryFixed: Color(4281616655),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280300032),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282205742),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280758042),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4279978566),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278203183),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292533199),
      surfaceBright: Color(4294638318),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243561),
      surfaceContainer: Color(4293849059),
      surfaceContainerHigh: Color(4293454301),
      surfaceContainerHighest: Color(4293125080),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4290105479),
      surfaceTint: Color(4290105479),
      onPrimary: Color(4280497664),
      primaryContainer: Color(4281879827),
      onPrimaryContainer: Color(4291947680),
      secondary: Color(4290890411),
      onSecondary: Color(4281021213),
      secondaryContainer: Color(4282468914),
      onSecondaryContainer: Color(4292732614),
      tertiary: Color(4288729289),
      onTertiary: Color(4278269747),
      tertiaryContainer: Color(4280241738),
      onTertiaryContainer: Color(4290571493),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279374862),
      onBackground: Color(4293125080),
      surface: Color(4279374862),
      onSurface: Color(4293125080),
      surfaceVariant: Color(4282730557),
      onSurfaceVariant: Color(4291152057),
      outline: Color(4287599237),
      outlineVariant: Color(4282730557),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293125080),
      inverseOnSurface: Color(4281282858),
      inversePrimary: Color(4283393577),
      primaryFixed: Color(4291947680),
      onPrimaryFixed: Color(4279377664),
      primaryFixedDim: Color(4290105479),
      onPrimaryFixedVariant: Color(4281879827),
      secondaryFixed: Color(4292732614),
      onSecondaryFixed: Color(4279705098),
      secondaryFixedDim: Color(4290890411),
      onSecondaryFixedVariant: Color(4282468914),
      tertiaryFixed: Color(4290571493),
      onTertiaryFixed: Color(4278198301),
      tertiaryFixedDim: Color(4288729289),
      onTertiaryFixedVariant: Color(4280241738),
      surfaceDim: Color(4279374862),
      surfaceBright: Color(4281874994),
      surfaceContainerLowest: Color(4279045897),
      surfaceContainerLow: Color(4279901205),
      surfaceContainer: Color(4280164377),
      surfaceContainerHigh: Color(4280888099),
      surfaceContainerHighest: Color(4281546286),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4290368650),
      surfaceTint: Color(4290105479),
      onPrimary: Color(4279114240),
      primaryContainer: Color(4286617942),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291153839),
      onSecondary: Color(4279310598),
      secondaryContainer: Color(4287337592),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4288992462),
      onTertiary: Color(4278196760),
      tertiaryContainer: Color(4285241748),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279374862),
      onBackground: Color(4293125080),
      surface: Color(4279374862),
      onSurface: Color(4294704368),
      surfaceVariant: Color(4282730557),
      onSurfaceVariant: Color(4291480765),
      outline: Color(4288783510),
      outlineVariant: Color(4286678391),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293125080),
      inverseOnSurface: Color(4280888099),
      inversePrimary: Color(4281945876),
      primaryFixed: Color(4291947680),
      onPrimaryFixed: Color(4278850560),
      primaryFixedDim: Color(4290105479),
      onPrimaryFixedVariant: Color(4280826882),
      secondaryFixed: Color(4292732614),
      onSecondaryFixed: Color(4278981379),
      secondaryFixedDim: Color(4290890411),
      onSecondaryFixedVariant: Color(4281415971),
      tertiaryFixed: Color(4290571493),
      onTertiaryFixed: Color(4278195218),
      tertiaryFixedDim: Color(4288729289),
      onTertiaryFixedVariant: Color(4278795577),
      surfaceDim: Color(4279374862),
      surfaceBright: Color(4281874994),
      surfaceContainerLowest: Color(4279045897),
      surfaceContainerLow: Color(4279901205),
      surfaceContainer: Color(4280164377),
      surfaceContainerHigh: Color(4280888099),
      surfaceContainerHighest: Color(4281546286),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294311900),
      surfaceTint: Color(4290105479),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290368650),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294311902),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291153839),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293656571),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4288992462),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279374862),
      onBackground: Color(4293125080),
      surface: Color(4279374862),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282730557),
      onSurfaceVariant: Color(4294638828),
      outline: Color(4291480765),
      outlineVariant: Color(4291480765),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293125080),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4280168192),
      primaryFixed: Color(4292211108),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290368650),
      onPrimaryFixedVariant: Color(4279114240),
      secondaryFixed: Color(4292996042),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291153839),
      onSecondaryFixedVariant: Color(4279310598),
      tertiaryFixed: Color(4290834666),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4288992462),
      onTertiaryFixedVariant: Color(4278196760),
      surfaceDim: Color(4279374862),
      surfaceBright: Color(4281874994),
      surfaceContainerLowest: Color(4279045897),
      surfaceContainerLow: Color(4279901205),
      surfaceContainer: Color(4280164377),
      surfaceContainerHigh: Color(4280888099),
      surfaceContainerHighest: Color(4281546286),
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


  List<ExtendedColor> get extendedColors => [
  ];
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
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

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

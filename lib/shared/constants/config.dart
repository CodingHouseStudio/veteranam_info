abstract class Config {
  static const _flavour =
      String.fromEnvironment('FLAVOUR', defaultValue: 'development');

  static bool get isDevelopment => _flavour == 'development';
  static bool get isProduction => _flavour == 'production';
  static bool get isStaging => _flavour == 'staging';
}

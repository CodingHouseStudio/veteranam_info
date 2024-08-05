import 'package:flutter/foundation.dart' show visibleForTesting;

abstract class Config {
  static const _flavour =
      String.fromEnvironment('FLAVOUR', defaultValue: development);

  @visibleForTesting
  static String? value;

  static bool get isDevelopment => (value ?? _flavour) == development;
  static bool get isProduction => (value ?? _flavour) == production;
  static bool get isStaging => (value ?? _flavour) == staging;
  @visibleForTesting
  static const development = 'development';
  @visibleForTesting
  static const production = 'production';
  @visibleForTesting
  static const staging = 'staging';
}

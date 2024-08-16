import 'package:flutter/foundation.dart' show visibleForTesting;

abstract class Config {
  static const flavour =
      String.fromEnvironment('FLAVOUR', defaultValue: development);

  @visibleForTesting
  static String? value;

  static bool get isDevelopment => (value ?? flavour) == development;
  static bool get isProduction => (value ?? flavour) == production;
  static bool get isStaging => (value ?? flavour) == _staging;
  // @visibleForTesting
  static const development = 'development';
  // @visibleForTesting
  static const production = 'production';
  // @visibleForTesting
  static const _staging = 'staging';
}

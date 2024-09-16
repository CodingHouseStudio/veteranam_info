import 'package:flutter/foundation.dart' show visibleForTesting;

abstract class Config {
  static const flavour =
      String.fromEnvironment('FLAVOUR', defaultValue: development);
  static const role = String.fromEnvironment('ROLE', defaultValue: _user);

  @visibleForTesting
  static String? falvourValue;

  @visibleForTesting
  static String? roleValue;

  static bool get isDevelopment => (falvourValue ?? flavour) == development;
  static bool get isProduction => (falvourValue ?? flavour) == production;
  static bool get isStaging => (falvourValue ?? flavour) == _staging;
  // @visibleForTesting
  static const development = 'development';
  // @visibleForTesting
  static const production = 'production';
  // @visibleForTesting
  static const _staging = 'staging';

  static bool get isUser => (roleValue ?? role) == _user;
  static bool get isBusiness => (roleValue ?? role) == _business;
  static const _user = 'user';
  static const _business = 'business';
}

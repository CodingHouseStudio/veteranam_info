import 'package:flutter/foundation.dart' show kIsWeb, visibleForTesting;

abstract class Config {
  static const flavour =
      String.fromEnvironment('FLAVOUR', defaultValue: development);
  static const role = String.fromEnvironment('ROLE', defaultValue: user);
  static const platform = kIsWeb ? web : mobile;

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

  static bool get isUser => (roleValue ?? role) == user;
  static bool get isBusiness => (roleValue ?? role) == business;
  // @visibleForTesting
  static const user = 'user';
  // @visibleForTesting
  static const business = 'business';

  static bool? _kIsWeb;
  static bool get isWeb => _kIsWeb ?? platform == web;
  @visibleForTesting
  static set isWeb(bool isWeb) => _kIsWeb = isWeb;
  // @visibleForTesting
  static const web = 'web';
  // @visibleForTesting
  static const mobile = 'mobile';
}

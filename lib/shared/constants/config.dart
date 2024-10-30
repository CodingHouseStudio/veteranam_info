import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;

abstract class Config {
  static const flavour =
      String.fromEnvironment('FLAVOUR', defaultValue: development);
  static const role = String.fromEnvironment('ROLE', defaultValue: user);
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

  // @visibleForTesting
  static const web = 'web';
  // @visibleForTesting
  static const mobile = 'mobile';

  static const String platform =
      bool.fromEnvironment('dart.library.js_util') ? Config.mobile : Config.web;

  static bool get isWeb => testIsWeb ?? platform == Config.web;
  @visibleForTesting
  static bool? testIsWeb;

  static bool _kReleaseMode = const bool.fromEnvironment('dart.vm.product');
  static bool get isReleaseMode => _kReleaseMode;
  @visibleForTesting
  static set isReleaseMode(bool releaseMode) => _kReleaseMode = releaseMode;
}

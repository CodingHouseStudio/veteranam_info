import 'dart:io' show Platform;

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

  static String get platform {
    try {
      // ignore: unused_local_variable
      final value = Platform.isAndroid;
      return Config.mobile;
    } catch (e) {
      return Config.web;
    }
  }

  static bool? _kIsWeb;
  static bool get isWeb => _kIsWeb ?? platform == Config.web;
  @visibleForTesting
  static set isWeb(bool isWeb) => _kIsWeb = isWeb;

  static bool _kReleaseMode = const bool.fromEnvironment('dart.vm.product');
  static bool get kReleaseMode => _kReleaseMode;
  @visibleForTesting
  static set kReleaseMode(bool releaseMode) => _kReleaseMode = releaseMode;
}

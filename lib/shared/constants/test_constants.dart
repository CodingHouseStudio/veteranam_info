import 'package:flutter/foundation.dart'
    show kIsWeb, kReleaseMode, visibleForTesting;

class KTest {
  static bool _cashe = true;
  static bool get cashe => _cashe;
  @visibleForTesting
  static set cashe(bool casheValue) => _cashe = casheValue;

  static bool _kIsWeb = kIsWeb;
  static bool get testIsWeb => _kIsWeb;
  @visibleForTesting
  static set testIsWeb(bool isWeb) => _kIsWeb = isWeb;

  static bool _kReleaseMode = kReleaseMode;
  static bool get testReleaseMode => _kReleaseMode;
  @visibleForTesting
  static set testReleaseMode(bool releaseMode) => _kReleaseMode = releaseMode;

  static bool _isTest = false;
  static bool get isTest => _isTest;
  @visibleForTesting
  static set isTest(bool value) => _isTest = value;

  // static double? _animatioRepeat;
  // static double? get animatioRepeat => _animatioRepeat;
  // @visibleForTesting
  // static set animatioRepeat(double? repeat) => _animatioRepeat = repeat;

  // static ScrollPhysics? _scroll = const BouncingScrollPhysics();
  // static ScrollPhysics? get scroll => _scroll;
  // @visibleForTesting
  // static set scroll(ScrollPhysics? scrollValue) => _scroll = scrollValue;
}

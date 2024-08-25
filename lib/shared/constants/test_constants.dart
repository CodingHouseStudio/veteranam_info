import 'package:flutter/foundation.dart' show kIsWeb, visibleForTesting;

class KTest {
  static bool _cashe = true;
  static bool get cashe => _cashe;
  @visibleForTesting
  static set cashe(bool casheValue) => _cashe = casheValue;

  static bool _kIsWeb = kIsWeb;
  static bool get testIsWeb => _kIsWeb;
  @visibleForTesting
  static set testIsWeb(bool isWeb) => _kIsWeb = isWeb;

  // static double? _animatioRepeat;
  // static double? get animatioRepeat => _animatioRepeat;
  // @visibleForTesting
  // static set animatioRepeat(double? repeat) => _animatioRepeat = repeat;

  // static ScrollPhysics? _scroll = const BouncingScrollPhysics();
  // static ScrollPhysics? get scroll => _scroll;
  // @visibleForTesting
  // static set scroll(ScrollPhysics? scrollValue) => _scroll = scrollValue;
}

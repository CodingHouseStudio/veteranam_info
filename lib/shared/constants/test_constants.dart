import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;

class KTest {
  static bool _cashe = true;
  static bool get cashe => _cashe;
  @visibleForTesting
  static set cashe(bool casheValue) => _cashe = casheValue;

  static bool _isTest = false;
  static bool get isTest => _isTest;
  @visibleForTesting
  static set isTest(bool value) => _isTest = value;

  static int getTimer(int value) => isTest ? 0 : value;

  // static double? _animatioRepeat;
  // static double? get animatioRepeat => _animatioRepeat;
  // @visibleForTesting
  // static set animatioRepeat(double? repeat) => _animatioRepeat = repeat;

  // static ScrollPhysics? _scroll = const BouncingScrollPhysics();
  // static ScrollPhysics? get scroll => _scroll;
  // @visibleForTesting
  // static set scroll(ScrollPhysics? scrollValue) => _scroll = scrollValue;
}

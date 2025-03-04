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

  static bool _isInterationTest = false;
  static bool get isInterationTest => _isInterationTest;
  @visibleForTesting
  static set isInterationTest(bool value) => _isInterationTest = value;

  static bool _testLoading = false;
  static bool get testLoading => _testLoading;
  @visibleForTesting
  static set testLoading(bool value) => _testLoading = value;

  static bool _discountSortingTestValue = false;
  static bool get discountSortingTestValue => _discountSortingTestValue;
  @visibleForTesting
  static set discountSortingTestValue(bool value) =>
      _discountSortingTestValue = value;

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

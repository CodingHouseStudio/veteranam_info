import 'package:flutter/foundation.dart';

class KTest {
  static bool _cashe = true;
  static bool get cashe => _cashe;
  @visibleForTesting
  static set cashe(bool casheValue) => _cashe = casheValue;

  static bool _kIsWeb = true;
  static bool get testIsWeb => _kIsWeb;
  @visibleForTesting
  static set testIsWeb(bool isWeb) => _kIsWeb = isWeb;
}

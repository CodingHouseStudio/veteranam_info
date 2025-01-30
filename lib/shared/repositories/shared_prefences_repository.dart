import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: ISharedPrefencesRepository)
class SharedPrefencesRepository implements ISharedPrefencesRepository {
  SharedPrefencesRepository() {
    _init();
  }
  SharedPreferences? _sharedPreferences;

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> initWait() async {
    var count = 0;
    while (_sharedPreferences == null && count < 100) {
      await Future.delayed(
        const Duration(milliseconds: 50),
        () => count++,
      );
    }
  }

  @override
  String? getString(String key) {
    try {
      return _sharedPreferences?.getString(key);
    } catch (e, stack) {
      SomeFailure.value(
        error: e,
        stack: stack,
        tag: 'getString',
        tagKey: 'SharedPrefencesRepository',
        data: 'Key: $key',
      );
      return null;
    }
  }

  @override
  Future<bool> setString({required String key, required String value}) async {
    try {
      await initWait();
      final value2 = await _sharedPreferences?.setString(key, value) ?? false;
      return value2;
    } catch (e, stack) {
      SomeFailure.value(
        error: e,
        stack: stack,
        tag: 'setString',
        tagKey: 'SharedPrefencesRepository',
        data: 'Key: $key, Value: $value',
      );
      return false;
    }
  }

  @override
  List<String>? getStringList(String key) {
    try {
      return _sharedPreferences?.getStringList(key);
    } catch (e, stack) {
      SomeFailure.value(
        error: e,
        stack: stack,
        tag: 'getStringList',
        tagKey: 'SharedPrefencesRepository',
        data: 'Key: $key',
      );
      return null;
    }
  }

  @override
  Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    try {
      await initWait();
      final value2 =
          await _sharedPreferences?.setStringList(key, value) ?? false;
      return value2;
    } catch (e, stack) {
      SomeFailure.value(
        error: e,
        stack: stack,
        tag: 'setStringList',
        tagKey: 'SharedPrefencesRepository',
        data: 'Key: $key, Value: $value',
      );
      return false;
    }
  }
}

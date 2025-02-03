import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: ISharedPrefencesRepository)
class SharedPrefencesRepository implements ISharedPrefencesRepository {
  SharedPrefencesRepository({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  String? getString(String key) {
    return valueErrorHelper(
      () => _sharedPreferences.getString(key),
      failureValue: null,
      methodName: 'getString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  @override
  Future<bool> setString({required String key, required String value}) async {
    return valueFutureErrorHelper(
      () async => _sharedPreferences.setString(key, value),
      failureValue: false,
      methodName: 'setString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  @override
  List<String>? getStringList(String key) {
    return valueErrorHelper(
      () => _sharedPreferences.getStringList(key),
      failureValue: null,
      methodName: 'getStringList',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  @override
  Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    return valueFutureErrorHelper(
      () async => _sharedPreferences.setStringList(key, value),
      failureValue: false,
      methodName: 'setStringList',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }
}

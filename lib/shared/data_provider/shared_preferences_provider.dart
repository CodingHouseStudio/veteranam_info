import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/shared/shared_dart.dart';

@singleton
class SharedPrefencesRepository {
  SharedPrefencesRepository({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String? getString(String key) {
    return valueErrorHelper(
      () => _sharedPreferences.getString(key),
      failureValue: null,
      methodName: 'getString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  Future<bool> setString({required String key, required String value}) async {
    return valueFutureErrorHelper(
      () async => _sharedPreferences.setString(key, value),
      failureValue: false,
      methodName: 'setString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key, Value: $value',
    );
  }

  List<String>? getStringList(String key) {
    return valueErrorHelper(
      () => _sharedPreferences.getStringList(key),
      failureValue: null,
      methodName: 'getStringList',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    return valueFutureErrorHelper(
      () async => _sharedPreferences.setStringList(key, value),
      failureValue: false,
      methodName: 'setStringList',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key, Value: $value',
    );
  }

  Future<bool> remove(
    String key,
  ) async {
    return valueFutureErrorHelper(
      () async => _sharedPreferences.remove(key),
      failureValue: false,
      methodName: 'remove',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }
}

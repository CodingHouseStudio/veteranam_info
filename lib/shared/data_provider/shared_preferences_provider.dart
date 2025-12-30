import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:veteranam/shared/shared_dart.dart';

@singleton
class SharedPrefencesProvider {
  final SharedPreferences _sharedPreferences = GetIt.I.get<SharedPreferences>();

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

  bool? getBool(String key) {
    return valueErrorHelper(
      () => _sharedPreferences.getBool(key),
      failureValue: null,
      methodName: 'getString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  Future<bool> setBool({required String key, required bool value}) async {
    return valueFutureErrorHelper(
      () async => _sharedPreferences.setBool(key, value),
      failureValue: false,
      methodName: 'setString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key, Value: $value',
    );
  }

  int? getInt(String key) {
    return valueErrorHelper(
      () => _sharedPreferences.getInt(key),
      failureValue: null,
      methodName: 'getString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
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

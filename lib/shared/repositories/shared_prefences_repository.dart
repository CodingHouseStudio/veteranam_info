import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(as: ISharedPrefencesRepository)
class SharedPrefencesRepository implements ISharedPrefencesRepository {
  SharedPrefencesRepository() {
    _init();
  }
  SharedPreferences? _sharedPreferences;

  @visibleForTesting
  static SharedPreferences? sharedPreferences;

  Future<void> _init() async {
    try {
      _sharedPreferences =
          sharedPreferences ?? await SharedPreferences.getInstance();
    } catch (e, stack) {
      SomeFailure.value(
        error: e,
        stack: stack,
        tagKey: 'Shared Prefences ${ErrorText.repositoryKey}',
        tag: '_init',
      );
      _sharedPreferences = null;
    }
  }

  @override
  Future<bool> initWait() async {
    var count = 0;
    while (_sharedPreferences == null && count < 100) {
      await Future.delayed(
        const Duration(milliseconds: 50),
        () => count++,
      );
    }
    unawaited(_init());
    return _sharedPreferences != null;
  }

  @override
  String? getString(String key) {
    return valueErrorHelper(
      () => _sharedPreferences?.getString(key),
      failureValue: null,
      methodName: 'getString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  @override
  Future<bool> setString({required String key, required String value}) async {
    return valueFutureErrorHelper(
      () async {
        await initWait();
        return _sharedPreferences?.setString(key, value) ?? false;
      },
      failureValue: false,
      methodName: 'setString',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }

  @override
  List<String>? getStringList(String key) {
    return valueErrorHelper(
      () => _sharedPreferences?.getStringList(key),
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
      () async {
        await initWait();
        return _sharedPreferences?.setStringList(key, value) ?? false;
      },
      failureValue: false,
      methodName: 'setStringList',
      className: 'Shared Prefences ${ErrorText.repositoryKey}',
      data: 'Key: $key',
    );
  }
}

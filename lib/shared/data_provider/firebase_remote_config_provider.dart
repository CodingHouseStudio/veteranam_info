import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart'
    show FirebaseRemoteConfig, RemoteConfigSettings;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/models/failure_model/failure_model.dart';

@singleton
class FirebaseRemoteConfigProvider {
  FirebaseRemoteConfigProvider({
    required FirebaseRemoteConfig firebaseRemoteConfig,
  }) : _firebaseRemoteConfig = firebaseRemoteConfig {
    // Initialization logic can't use await directly in constructor
    _initCallback = _initRemoteConfigSettings();
  }

  final FirebaseRemoteConfig _firebaseRemoteConfig;
  late Future<bool> _initCallback;
  Timer? _timer;

  Future<bool> _initRemoteConfigSettings() async {
    return valueFutureErrorHelper(
      () async {
        await _firebaseRemoteConfig.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 2),
            minimumFetchInterval: const Duration(minutes: 1),
          ),
        );
        await _firebaseRemoteConfig.fetchAndActivate();
        return true;
      },
      failureValue: false,
      methodName: '_initRemoteConfigSettings',
      className: 'FirebaseRemoteConfigProvider',
    );
  }

  Future<bool> waitActivated() async {
    return _initCallback;
  }

  int getInt(String key) {
    try {
      return _firebaseRemoteConfig.getInt(
        key,
      );
    } catch (e) {
      return 0;
    }
  }

  String getString(String key) {
    try {
      return _firebaseRemoteConfig.getString(
        key,
      );
    } catch (e) {
      return '';
    }
  }

  bool getBool(String key) {
    try {
      return _firebaseRemoteConfig.getBool(
        key,
      );
    } catch (e) {
      return false;
    }
  }

  @disposeMethod
  void dispose() {
    _timer?.cancel();
  }
}

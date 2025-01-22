import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart'
    show FirebaseRemoteConfig, RemoteConfigFetchStatus, RemoteConfigSettings;
import 'package:injectable/injectable.dart';

@singleton
class FirebaseRemoteConfigProvider {
  FirebaseRemoteConfigProvider({
    required FirebaseRemoteConfig firebaseRemoteConfig,
  }) : _firebaseRemoteConfig = firebaseRemoteConfig {
    // Initialization logic can't use await directly in constructor
    _initRemoteConfigSettings();
  }

  final FirebaseRemoteConfig _firebaseRemoteConfig;
  Timer? _timer;

  Future<void> _initRemoteConfigSettings() async {
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 2),
        minimumFetchInterval: const Duration(minutes: 1),
      ),
    );
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  Future<bool> waitActivated() async {
    try {
      var count = 0;
      while ((_firebaseRemoteConfig.lastFetchStatus ==
                  RemoteConfigFetchStatus.noFetchYet ||
              _firebaseRemoteConfig.getAll().isEmpty) &&
          count < 100) {
        await Future.delayed(
          const Duration(milliseconds: 100),
          () => count++,
        );
      }
      return _firebaseRemoteConfig.lastFetchStatus !=
          RemoteConfigFetchStatus.noFetchYet;
    } catch (e) {
      return false;
    }
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

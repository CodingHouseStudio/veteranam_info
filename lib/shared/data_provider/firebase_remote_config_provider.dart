import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirebaseRemoteConfigProvider {
  FirebaseRemoteConfigProvider(
    this._firebaseRemoteConfig,
  ) {
    // Initialization logic can't use await directly in constructor
    _initRemoteConfigSettings();
  }

  final FirebaseRemoteConfig _firebaseRemoteConfig;

  Future<void> _initRemoteConfigSettings() async {
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 2),
        minimumFetchInterval: const Duration(minutes: 1),
      ),
    );

    await _firebaseRemoteConfig.fetchAndActivate();
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
}

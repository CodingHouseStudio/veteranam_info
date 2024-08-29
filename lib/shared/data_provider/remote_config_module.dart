import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RemoteConfigModule {
  @singleton
  FirebaseRemoteConfig get firebaseRemoteConfig =>
      FirebaseRemoteConfig.instance;
}

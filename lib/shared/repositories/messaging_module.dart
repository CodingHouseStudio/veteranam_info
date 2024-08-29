import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@module
abstract class MessagingModule {
  @singleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @singleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}

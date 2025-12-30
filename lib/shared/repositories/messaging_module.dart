import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:injectable/injectable.dart';

import 'package:firebase_messaging/firebase_messaging.dart'
    show FirebaseMessaging;

@module
abstract class MessagingModule {
  @Singleton(order: -2)
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @Singleton(order: -2)
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}

import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Evnironment {
  static Future<void> loadEnv() async {
    try {
      await dotenv.load();
    } catch (e) {
      log(
        'Environmnet file not created',
        name: 'Environment',
      );
    }
  }

  static final sentryDSN = dotenv.env['SENTRY_DSN'] ?? '';
  static final firebaseAppCheckProd =
      dotenv.env['FIREBASE_APP_CHECK_PROD'] ?? '';
  static final firebaseAppCheckDev = dotenv.env['FIREBASE_APP_CHECK_DEV'] ?? '';
  static final firebaseProdVapidKey =
      dotenv.env['FIREBASE_VAPID_PROD_KEY'] ?? '';
  static final firebaseDevVapidKey = dotenv.env['FIREBASE_VAPID_DEV_KEY'] ?? '';
  static final appStoreId = dotenv.env['APP_STORE_ID'] ?? '';
}

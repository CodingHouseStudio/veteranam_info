abstract class KSecurityKeys {
  static const appStoreId = String.fromEnvironment('APP_STORE_ID');
  static const firebaseProdVapidKey =
      String.fromEnvironment('FIREBASE_VAPID_PROD_KEY');
  static const firebaseDevVapidKey =
      String.fromEnvironment('FIREBASE_VAPID_DEV_KEY');
  static const sentryDSN = String.fromEnvironment('SENTRY_DSN');
  static const firebaseAppCheckProd =
      String.fromEnvironment('FIREBASE_APP_CHECK_PROD');
  static const firebaseAppCheckDev =
      String.fromEnvironment('FIREBASE_APP_CHECK_DEV');
}

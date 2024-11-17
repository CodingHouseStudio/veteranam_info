abstract class KSecurityKeys {
  static const firebaseVapidKey = String.fromEnvironment('FIREBASE_VAPID_KEY');
  static const sentryDSN = String.fromEnvironment('SENTRY_DSN');
  static const firebaseAppCheck = String.fromEnvironment('FIREBASE_APP_CHECK');
}

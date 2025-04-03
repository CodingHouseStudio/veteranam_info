abstract class KSecurityKeys {
  static const firebaseVapidKey = String.fromEnvironment('FIREBASE_VAPID_KEY');
  static const sentryDSN = String.fromEnvironment('SENTRY_DSN');
  static const firebaseAppCheck = String.fromEnvironment('FIREBASE_APP_CHECK');
  static const alogoliaApiKey = String.fromEnvironment('ALGOLIA_API_KEY');
  static const androidBanerAdsID =
      String.fromEnvironment('ANDROID_GOOGLE_ADS_BANNER_ID');
  static const iosBanerAdsID =
      String.fromEnvironment('IOS_GOOGLE_ADS_BANNER_ID');
}

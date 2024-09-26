// ignore_for_file: empty_catches

import 'dart:developer' show log;

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart'
    show PlatformDispatcher, kIsWeb, kReleaseMode;
import 'package:flutter/material.dart' show FlutterError, WidgetsFlutterBinding;
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_production.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: PROD main file
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kReleaseMode) {
    if (kIsWeb) {
      await SentryFlutter.init(
        (options) {
          options
            ..dsn = KSecurityKeys.sentryDSN
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for
            // performance monitoring.
            // We recommend adjusting this value in production.
            ..tracesSampleRate = 1.0
            // The sampling rate for profiling is relative to tracesSampleRate
            // Setting to 1.0 will profile 100% of sampled transactions:
            ..profilesSampleRate = 1.0
            // ignore package error
            ..reportPackages = false
            // add information about threads
            ..attachThreads = true
            ..reportSilentFlutterErrors = true
            // Add screenshot for error
            ..attachScreenshot = true
            // Optimization screenshot
            ..screenshotQuality = SentryScreenshotQuality.low
            // Add hierarchy for error report
            ..attachViewHierarchy = true
            // Turns on Spotlight functionality, which can help you track
            // certain events or conditions.
            ..spotlight = Spotlight(enabled: true)
            // Turns on time tracking until full display to help you understand
            // the performance of the app's loading.
            ..enableTimeToFullDisplayTracing = true;
        },
      );
    }

    // try {
    if (kIsWeb) {
      await FirebasePerformance.instanceFor(app: app)
          .setPerformanceCollectionEnabled(kReleaseMode);

      //   final temp = await FirebasePerformance.instanceFor(app: app)
      //       .isPerformanceCollectionEnabled();
      //   if (temp) {
      //     await FirebasePerformance.instanceFor(app: app)
      //         .newTrace('test-web')
      //         .start();
      //     print('Performance collection is enabled');

      //     await FirebasePerformance.instanceFor(app: app)
      //         .newTrace('test-web')
      //         .stop();
      //   } else {
      //     print('Performance collection is disabled');
      //   }
    } else {
      await FirebasePerformance.instance
          .setPerformanceCollectionEnabled(kReleaseMode);
    }
    // } catch (e, stack) {}
  }
  try {
    // if (!kIsWeb)
    // {
    await FirebaseAppCheck.instanceFor(app: app).activate(
      webProvider: ReCaptchaV3Provider(
        KSecurityKeys.firebaseAppCheckProd,
      ),
      androidProvider:
          kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
      appleProvider:
          kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
    );
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider(
        KSecurityKeys.firebaseAppCheckProd,
      ),
      androidProvider:
          kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
      appleProvider:
          kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
    );
  } catch (e) {}

  // Non-async exceptions
  FlutterError.onError = (details) {
    if (kReleaseMode) {
      if (kIsWeb) {
        Sentry.captureException(
          details.exceptionAsString(),
          stackTrace: details.stack,
        );
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(details);
      }
    }
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kReleaseMode) {
      if (kIsWeb) {
        Sentry.captureException(
          error,
          stackTrace: stack,
        );
      } else {
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
    }
    log(error.toString(), stackTrace: stack);

    return true;
  };

  // if (kIsWeb) {
  // initialize the facebook javascript SDK
  // TODO(appId): set value
  // await FacebookAuth.i.webAndDesktopInitialize(
  //   appId: 'YOUR_FACEBOOK_APP_ID',
  //   cookie: true,
  //   xfbml: true,
  //   version: 'v15.0',
  // );
  // }

  await bootstrap(App.new);
}

// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            ..dsn = SecurityKeys.sentryDSN
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for
            // performance monitoring.
            // We recommend adjusting this value in production.
            ..tracesSampleRate = 1.0
            // The sampling rate for profiling is relative to tracesSampleRate
            // Setting to 1.0 will profile 100% of sampled transactions:
            ..profilesSampleRate = 1.0;
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
    // } catch (e) {}
    try {
      if (!kIsWeb)
      // {
      //   if (kReleaseMode) {
      //     await FirebaseAppCheck.instanceFor(app: app).activate(
      //       webProvider: ReCaptchaV3Provider(
      //         '6LevUCsqAAAAAEG431Qk2NsMNXurWJ8vs89UkrEG',
      //       ),
      //     );
      //   } else {
      //     await FirebaseAppCheck.instanceFor(app: app).activate(
      //       webProvider: ReCaptchaV3Provider(
      //         '326946D7-ABAE-4F1A-AEE7-395C5E23F0D4',
      //       ),
      //     );
      //   }
      // } else
      {
        await FirebaseAppCheck.instance.activate(
          androidProvider: kReleaseMode
              ? AndroidProvider.playIntegrity
              : AndroidProvider.debug,
          appleProvider:
              kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
        );
      }
    } catch (e) {}

    // Non-async exceptions
    FlutterError.onError = (details) {
      if (kIsWeb) {
        Sentry.captureException(
          details.exceptionAsString(),
          stackTrace: details.stack,
        );
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(details);
      }
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    // Async exceptions
    PlatformDispatcher.instance.onError = (error, stack) {
      if (kIsWeb) {
        Sentry.captureException(
          error,
          stackTrace: stack,
        );
      } else {
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
      log(error.toString(), stackTrace: stack);

      return true;
    };
  }

  await bootstrap(App.new);
}

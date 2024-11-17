// ignore_for_file: empty_catches

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart'
    show DiagnosticLevel, FlutterErrorDetails, PlatformDispatcher;
import 'package:flutter/material.dart' show FlutterError, WidgetsFlutterBinding;
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_production.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/enum.dart';
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/constants/text/error_text.dart';
import 'package:veteranam/shared/repositories/failure_repository.dart';

/// COMMENT: PROD main file
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Config.isReleaseMode) {
    // if (Config.isWeb) {
    //   await SentryFlutter.init(
    //     (options) {
    //       options
    //         ..dsn = KSecurityKeys.sentryDSN
    //         // Set tracesSampleRate to 1.0 to capture 100% of transactions for
    //         // performance monitoring.
    //         // We recommend adjusting this value in production.
    //         ..tracesSampleRate = 1.0
    //         // The sampling rate for profiling is relative to tracesSampleRate
    //         // Setting to 1.0 will profile 100% of sampled transactions:
    //         ..profilesSampleRate = 1.0
    //         // ignore package error
    //         ..reportPackages = false
    //         // add information about threads
    //         ..attachThreads = true
    //         ..reportSilentFlutterErrors = true
    //         // Add screenshot for error
    //         ..attachScreenshot = true
    //         // Optimization screenshot
    //         ..screenshotQuality = SentryScreenshotQuality.low
    //         // Add hierarchy for error report
    //         ..attachViewHierarchy = true
    //         // Turns on Spotlight functionality, which can help you track
    //         // certain events or conditions.
    //         ..spotlight = Spotlight(enabled: true)
    //         // Turns on time tracking until full display to help you understand
    //         // the performance of the app's loading.
    //         ..enableTimeToFullDisplayTracing = true;
    //     },
    //   );
    // }

    // try {
    if (Config.isWeb) {
      await FirebasePerformance.instanceFor(app: app)
          .setPerformanceCollectionEnabled(Config.isReleaseMode);

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
          .setPerformanceCollectionEnabled(Config.isReleaseMode);
    }
    // } catch (e, stack) {}
  }
  try {
    // if (!Config.isWeb)
    // {
    await FirebaseAppCheck.instanceFor(app: app).activate(
      webProvider: ReCaptchaV3Provider(
        KSecurityKeys.firebaseAppCheck,
      ),
      androidProvider: Config.isReleaseMode
          ? AndroidProvider.playIntegrity
          : AndroidProvider.debug,
      appleProvider: Config.isReleaseMode
          ? AppleProvider.deviceCheck
          : AppleProvider.debug,
    );
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider(
        KSecurityKeys.firebaseAppCheck,
      ),
      androidProvider: Config.isReleaseMode
          ? AndroidProvider.playIntegrity
          : AndroidProvider.debug,
      appleProvider: Config.isReleaseMode
          ? AppleProvider.deviceCheck
          : AppleProvider.debug,
    );
  } catch (e) {}

  // Non-async exceptions handling
  FlutterError.onError = (details) {
    // Declare error level variable for classification
    late ErrorLevelEnum errorLevel;

    // Determine the error level based on exception type or details
    if (details.exception is AssertionError ||
        details.exception.toString().contains('OutOfMemoryError')) {
      // Set as fatal for critical issues
      errorLevel = ErrorLevelEnum.fatal;
    } else if (details.stack != null) {
      // Set as error if stack trace is available
      errorLevel = ErrorLevelEnum.error;
    } else if (details.informationCollector != null) {
      // Set as info if additional information is available
      errorLevel = ErrorLevelEnum.info;
    } else {
      // Set as warning for less severe issues
      errorLevel = ErrorLevelEnum.warning;
    }

    // Log the error details to FailureRepository with specified level and tags
    FailureRepository.onError(
      error: details,
      stack: details.stack,
      information: details.informationCollector?.call(),
      reason:
          details.context?.toStringDeep(minLevel: DiagnosticLevel.info).trim(),
      errorLevel: errorLevel,
      tag: ErrorText.nonAsync, // Tag to identify non-async exceptions
      tagKey:
          ErrorText.mainFileKey, // Key for identifying error location/source
    );
  };

// Async exceptions handling
  PlatformDispatcher.instance.onError = (error, stack) {
    // Log the error details to FailureRepository with specified level and tags
    FailureRepository.onError(
      error: error,
      stack: stack,
      reason: null, // No specific reason provided for async errors
      information: null, // No additional information for async errors
      tag: ErrorText.async, // Tag to identify async exceptions
      tagKey:
          ErrorText.mainFileKey, // Key for identifying error location/source
      errorLevel: null,
    );

    return true; // Return true to indicate the error has been handled
  };

  // if (Config.isWeb) {
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

// Future<void> _onError({
//   required Object error,
//   required StackTrace? stack,
// }) async {
//   if (Config.isReleaseMode) {
//     if (Config.isWeb) {
//       if (_isCrashlyticsLoaded) {
//         await sentry.loadLibrary();
//         _isCrashlyticsLoaded = true;
//       }
//       if (!sentry.Sentry.isEnabled) {
//         await sentry.SentryFlutter.init(
//           (options) {
//             options
//               ..dsn = KSecurityKeys.sentryDSN
//               // Set tracesSampleRate to 1.0 to capture 100% of transactions for
//               // performance monitoring.
//               // We recommend adjusting this value in production.
//               ..tracesSampleRate = 1.0
//               // The sampling rate for profiling is relative to tracesSampleRate
//               // Setting to 1.0 will profile 100% of sampled transactions:
//               ..profilesSampleRate = 1.0
//               // ignore package error
//               ..reportPackages = false
//               // add information about threads
//               ..attachThreads = true
//               ..reportSilentFlutterErrors = true
//               // Add screenshot for error
//               ..attachScreenshot = true
//               // Optimization screenshot
//               ..screenshotQuality = sentry.SentryScreenshotQuality.low
//               // Add hierarchy for error report
//               ..attachViewHierarchy = true
//               // Turns on Spotlight functionality, which can help you track
//               // certain events or conditions.
//               ..spotlight = sentry.Spotlight(enabled: true)
//               // Turns on time tracking until full display to help you
//               // understand
//               // the performance of the app's loading.
//               ..enableTimeToFullDisplayTracing = true;
//           },
//         );
//       }
//       await sentry.Sentry.captureException(
//         error is FlutterErrorDetails ? error.exceptionAsString() : error,
//         stackTrace: stack,
//       );
//     } else {
//       if (_isCrashlyticsLoaded) {
//         await firebase_crashlytics.loadLibrary();
//         _isCrashlyticsLoaded = true;
//       }
//       if (error is FlutterErrorDetails) {
//         await firebase_crashlytics.FirebaseCrashlytics.instance
//             .recordFlutterError(error);
//       } else {
//         await firebase_crashlytics.FirebaseCrashlytics.instance
//             .recordError(error, stack);
//       }
//     }
//   }
// }

// bool _isCrashlyticsLoaded = false;

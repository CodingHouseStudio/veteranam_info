import 'dart:developer' show log;

import 'package:firebase_crashlytics/firebase_crashlytics.dart'
    deferred as firebase_crashlytics;
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart' deferred as sentry
    show Sentry, SentryFlutter, SentryScreenshotQuality, Spotlight;
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

@LazySingleton(order: -2)
class FailureRepository {
  void sendError(SomeFailure failure) {
    if (KTest.isTest) return;
    final error = failure.error;
    final stack = failure.stack;
    if (error != null) {
      onError(error: error, stack: stack);
    }
  }

  static Future<void> onError({
    required Object error,
    required StackTrace? stack,
    String? reason,
    Iterable<Object>? information,
  }) async {
    if (Config.isReleaseMode && Config.isProduction) {
      if (Config.isWeb) {
        await sentry.loadLibrary();
        if (!sentry.Sentry.isEnabled) {
          await sentry.SentryFlutter.init(
            (options) {
              options
                ..dsn = KSecurityKeys.sentryDSN
                // Set tracesSampleRate to 1.0 to capture 100% of
                // transactions for
                // performance monitoring.
                // We recommend adjusting this value in production.
                ..tracesSampleRate = 1.0
                // The sampling rate for profiling is relative to
                // tracesSampleRate
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
                ..screenshotQuality = sentry.SentryScreenshotQuality.low
                // Add hierarchy for error report
                ..attachViewHierarchy = true
                // Turns on Spotlight functionality, which can help you track
                // certain events or conditions.
                ..spotlight = sentry.Spotlight(enabled: true)
                // Turns on time tracking until full display to help you
                // understand
                // the performance of the app's loading.
                ..enableTimeToFullDisplayTracing = true
                ..environment =
                    'FLAVOUR = ${Config.flavour}, ROLE = ${Config.role} '
                        '${Config.isWeb ? Uri.base.origin : ''}';
            },
          );
        }
        await sentry.Sentry.captureException(
          error,
          stackTrace: stack,
        );
      } else {
        await firebase_crashlytics.loadLibrary();
        await firebase_crashlytics.FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          reason: reason,
          information: information ?? const [],
          printDetails: information == null,
        );
      }
    }
    log('EXCEPTION: $error', stackTrace: stack);
  }
}

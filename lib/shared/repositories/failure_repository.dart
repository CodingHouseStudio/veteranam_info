import 'dart:async';
import 'dart:developer' show log;

import 'package:firebase_crashlytics/firebase_crashlytics.dart'
    deferred as firebase_crashlytics;
import 'package:get_it/get_it.dart';
// import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart' deferred as sentry
    show
        Sentry,
        SentryFlutter,
        SentryLevel,
        SentryScreenshotQuality,
        SentryUser,
        Spotlight;
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/shared_dart.dart';

// @LazySingleton(order: -2)
class FailureRepository {
  static FutureOr<void> onError({
    required Object error,
    required StackTrace? stack,
    required String? reason,
    required Iterable<Object>? information,
    required ErrorLevelEnum errorLevel,
    required String? tag,
    required String? tagKey,
    String? tag2,
    String? tag2Key,
    String? data,
    User? user,
    UserSetting? userSetting,
  }) async {
    // Define the variable for error level categorization
    if (KTest.isInterationTest ||
        (Config.isReleaseMode &&
            Config.isProduction &&
            // GDPR: also neccesary user agree
            GetIt.I.get<FirebaseAnalyticsCacheController>().currentState)) {
      try {
        if (Config.isWeb) {
          await sentry.loadLibrary();
          // hasError = true;
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
                      'FLAVOUR = ${Config.flavour}, ROLE = ${Config.role} ';
              },
            );
          }
          await sentry.Sentry.captureException(
            error,
            stackTrace: stack,
            withScope: (scope) async {
              switch (errorLevel) {
                case ErrorLevelEnum.error:
                  scope.level = sentry.SentryLevel.error;
                case ErrorLevelEnum.fatal:
                  scope.level = sentry.SentryLevel.fatal;
                case ErrorLevelEnum.info:
                  scope.level = sentry.SentryLevel.info;
                case ErrorLevelEnum.warning:
                  scope.level = sentry.SentryLevel.warning;
              }
              if (tag != null) {
                await scope.setTag(tagKey ?? ErrorText.standartKey, tag);
              }
              if (tag2 != null) {
                await scope.setTag(tag2Key ?? ErrorText.standartKey, tag2);
              }
              if (data != null) {
                await scope.setTag(ErrorText.dataKey, data);
              }
              await scope.setUser(
                sentry.SentryUser(
                  id: user?.id,
                  name: user?.name,
                  username: userSetting?.nickname,
                  email: user?.email,
                ),
              );
            },
          );
        } else {
          await firebase_crashlytics.loadLibrary();
          await firebase_crashlytics.FirebaseCrashlytics.instance.recordError(
            error,
            stack,
            reason: reason ?? errorLevel.getString,
            information: information ?? const [],
            printDetails: information == null,
            fatal: errorLevel == ErrorLevelEnum.fatal,
          );
          if (tag != null) {
            await firebase_crashlytics.FirebaseCrashlytics.instance
                .setCustomKey(
              tagKey.toString(),
              tag,
            );
          }
          if (tag2 != null) {
            await firebase_crashlytics.FirebaseCrashlytics.instance
                .setCustomKey(
              tag2Key.toString(),
              tag2,
            );
          }
          if (data != null) {
            await firebase_crashlytics.FirebaseCrashlytics.instance
                .setCustomKey(
              ErrorText.dataKey,
              data,
            );
          }
        }
      } catch (e) {
        log('EXCEPTION send Error');
      }
    }
    log(
      'EXCEPTION $tagKey: $tag.',
      stackTrace: stack,
      error: error,
      name: 'ERROR!!!',
      level: errorLevel.getLevel,
      sequenceNumber: errorLevel.getSequenceNumber,
    );
  }

  // static bool hasError = false;

  // @disposeMethod
  // void dispose() => Config.isWeb && hasError ? sentry.Sentry.close() : null;
}

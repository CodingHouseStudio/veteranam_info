import 'dart:async';
import 'dart:developer' show log;

import 'package:firebase_crashlytics/firebase_crashlytics.dart'
    deferred as firebase_crashlytics;
import 'package:injectable/injectable.dart';
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

@LazySingleton(order: -2)
class FailureRepository {
  void sendError(SomeFailure failure) {
    if (KTest.isTest) return;
    final error = failure.error;
    if (error ==
        '[cloud_firestore/failed-precondition] The client has already been terminated.') {
      return;
    }
    if (error != null) {
      onError(
        error: error,
        stack: failure.stack,
        reason: null,
        information: null,
        errorLevel: failure.errorLevel,
        tag: failure.tag,
        tagKey: failure.tagKey,
        data: failure.data,
        tag2: failure.tag2,
        tag2Key: failure.tag2Key,
      );
    }
  }

  static FutureOr<void> onError({
    required Object error,
    required StackTrace? stack,
    required String? reason,
    required Iterable<Object>? information,
    required ErrorLevelEnum? errorLevel,
    required String? tag,
    required String? tagKey,
    bool? isInfo,
    String? tag2,
    String? tag2Key,
    String? data,
    User? user,
    UserSetting? userSetting,
  }) async {
    // Define the variable for error level categorization
    var errorLevelValue = errorLevel;
    if (errorLevelValue == null) {
      final errorString = error.toString().toLowerCase();

      // Determine the error level based on the exception type or error content
      if (isInfo ??
          false ||
              errorString.contains('timeout') ||
              errorString.contains('connection refused') ||
              errorString.contains('no internet') ||
              errorString.contains('network-request') ||
              errorString.contains('resource limit exceeded') ||
              errorString.contains('permission-denied') ||
              errorString.contains('offline') ||
              errorString.contains('failed-precondition')) {
        // Info level for network-related issues or resource constraints
        errorLevelValue = ErrorLevelEnum.info;
      } else if (error is AssertionError ||
          errorString.contains('outofmemoryerror')) {
        // Fatal level for critical asynchronous issues that cause crashes
        errorLevelValue = ErrorLevelEnum.fatal;
      } else if (errorString.contains('deprecated') ||
          errorString.contains('slow') ||
          errorString.contains('performance')) {
        // Warning level for performance concerns or deprecated code usage
        errorLevelValue = ErrorLevelEnum.warning;
      } else {
        // Default error level for general asynchronous issues
        errorLevelValue = ErrorLevelEnum.error;
      }
    }

    if (Config.isReleaseMode && Config.isProduction) {
      if (Config.isWeb) {
        await sentry.loadLibrary();
        hasError = true;
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
            switch (errorLevelValue) {
              case ErrorLevelEnum.error:
                scope.level = sentry.SentryLevel.error;
              case ErrorLevelEnum.fatal:
                scope.level = sentry.SentryLevel.fatal;
              case ErrorLevelEnum.info:
                scope.level = sentry.SentryLevel.info;
              case ErrorLevelEnum.warning:
                scope.level = sentry.SentryLevel.warning;
              case null:
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
          reason: reason ?? errorLevel?.getString,
          information: information ?? const [],
          printDetails: information == null,
          fatal: errorLevelValue == ErrorLevelEnum.fatal,
        );
        if (tag != null) {
          await firebase_crashlytics.FirebaseCrashlytics.instance.setCustomKey(
            tagKey.toString(),
            tag,
          );
        }
        if (tag2 != null) {
          await firebase_crashlytics.FirebaseCrashlytics.instance.setCustomKey(
            tag2Key.toString(),
            tag2,
          );
        }
        if (data != null) {
          await firebase_crashlytics.FirebaseCrashlytics.instance.setCustomKey(
            ErrorText.dataKey,
            data,
          );
        }
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

  static bool hasError = false;

  @disposeMethod
  void dispose() => Config.isWeb && hasError ? sentry.Sentry.close() : null;
}

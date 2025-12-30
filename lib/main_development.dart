import 'dart:developer';

import 'package:flutter/material.dart' show FlutterError, WidgetsFlutterBinding;

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_development.dart';
import 'package:veteranam/shared/bloc/badger/badger_cubit.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/enum.dart';
import 'package:veteranam/shared/constants/text/error_text.dart';
import 'package:veteranam/shared/models/failure_model/some_failure.dart';
import 'package:veteranam/shared/repositories/failure_repository.dart';

import 'package:flutter/foundation.dart'
    show DiagnosticLevel, PlatformDispatcher;
import 'package:flutter_app_badger/flutter_app_badger.dart'
    deferred as app_badger;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message: ${message.messageId}');
  await app_badger.loadLibrary();
  // Update Badge count for background
  if (await app_badger.FlutterAppBadger.isAppBadgeSupported()) {
    final sharedPrefences = await SharedPreferences.getInstance();

    final currentValue = sharedPrefences.getInt(BadgerCubit.badgeCacheKey);

    final newValue = (currentValue ?? 0) + 1;

    await app_badger.FlutterAppBadger.updateBadgeCount(newValue);

    await sharedPrefences.setInt(BadgerCubit.badgeCacheKey, newValue);
  }
}

/// COMMENT: DEV main file
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final app =
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    // Skip Firebase App Check on web for development
    // Only enable on mobile platforms
    if (!Config.isWeb) {
      await FirebaseAppCheck.instanceFor(app: app).activate(
        androidProvider: Config.isReleaseMode
            ? AndroidProvider.playIntegrity
            : AndroidProvider.debug,
        appleProvider: Config.isReleaseMode
            ? AppleProvider.deviceCheck
            : AppleProvider.debug,
      );
      await FirebaseAppCheck.instance.activate(
        androidProvider: Config.isReleaseMode
            ? AndroidProvider.playIntegrity
            : AndroidProvider.debug,
        appleProvider: Config.isReleaseMode
            ? AppleProvider.deviceCheck
            : AppleProvider.debug,
      );
      log(
        'Firebase AppCheck enabled for mobile',
        name: 'Firebase AppCheck',
      );
    } else {
      log(
        'Skipping Firebase AppCheck on web for development',
        name: 'Firebase AppCheck',
      );
    }
  } catch (e, stack) {
    log(
      'Firebase AppCheck Error',
      name: 'Firebase AppCheck',
      error: e,
      stackTrace: stack,
    );
  }

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
      error: details.exception,
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
    SomeFailure.value(
      error: error,
      stack: stack,
      tag: ErrorText.async, // Tag to identify async exceptions
      tagKey:
          ErrorText.mainFileKey, // Key for identifying error location/source
    );

    return true; // Return true to indicate the error has been handled
  };

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await bootstrap(App.new);
}

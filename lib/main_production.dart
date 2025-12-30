import 'dart:async';
import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart'
    show DiagnosticLevel, PlatformDispatcher;
import 'package:flutter/material.dart' show FlutterError, WidgetsFlutterBinding;
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_production.dart';
import 'package:veteranam/shared/bloc/badger/badger_cubit.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/enum.dart';
import 'package:veteranam/shared/constants/security_keys.dart';
import 'package:veteranam/shared/constants/text/error_text.dart';
import 'package:veteranam/shared/models/failure_model/some_failure.dart';
import 'package:veteranam/shared/repositories/failure_repository.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message: ${message.messageId}');

  if (await FlutterAppBadger.isAppBadgeSupported()) {
    final sharedPrefences = await SharedPreferences.getInstance();

    final currentValue = sharedPrefences.getInt(BadgerCubit.badgeCacheKey);

    final newValue = (currentValue ?? 0) + 1;

    final checkValue = newValue > 0 ? newValue : 1;

    await FlutterAppBadger.updateBadgeCount(checkValue);

    await sharedPrefences.setInt(BadgerCubit.badgeCacheKey, checkValue);
  }
}

/// COMMENT: PROD main file
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (Config.isReleaseMode) {
    if (Config.isWeb) {
      await FirebasePerformance.instanceFor(app: app)
          .setPerformanceCollectionEnabled(Config.isReleaseMode);
    } else {
      await FirebasePerformance.instance
          .setPerformanceCollectionEnabled(Config.isReleaseMode);
    }
  }
  try {
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
    SomeFailure.value(
      error: error,
      stack: stack,
      tag: ErrorText.async, // Tag to identify async exceptions
      tagKey:
          ErrorText.mainFileKey, // Key for identifying error location/source
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

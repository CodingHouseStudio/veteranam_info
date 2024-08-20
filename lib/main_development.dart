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
import 'package:veteranam/firebase_options_development.dart';

/// COMMENT: DEV main file
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    if (kIsWeb) {
      await FirebasePerformance.instanceFor(app: app)
          .setPerformanceCollectionEnabled(kReleaseMode);
    } else {
      await FirebasePerformance.instance
          .setPerformanceCollectionEnabled(kReleaseMode);
    }
  } catch (e) {
    print('firebase performance issue');
    print(e);
  }
  try {
    if (kIsWeb) {
      final temp = await FirebaseAppCheck.instanceFor(app: app).activate(
        webProvider: ReCaptchaEnterpriseProvider(kReleaseMode
            ? 'REDACTED'
            : '4A104621-0F8F-4D82-A07F-008910737512'),
      );
    } else {
      await FirebaseAppCheck.instance.activate(
        androidProvider: kReleaseMode
            ? AndroidProvider.playIntegrity
            : AndroidProvider.debug,
        appleProvider: kReleaseMode
            ? AppleProvider.appAttestWithDeviceCheckFallback
            : AppleProvider.debug,
      );
    }
  } catch (e) {
    print('firebase app check issue');
    print(e);
  }

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

    return true;
  };

  await bootstrap(App.new);
}

// ignore_for_file: empty_catches

import 'dart:developer' show log;

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher;
// import 'package:flutter/foundation.dart' show Config.isReleaseMode;
import 'package:flutter/material.dart' show FlutterError, WidgetsFlutterBinding;
import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_development.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/security_keys.dart';

/// COMMENT: DEV main file
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final app =
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await FirebaseAppCheck.instanceFor(app: app).activate(
      webProvider: ReCaptchaV3Provider(
        KSecurityKeys.firebaseAppCheckDev,
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
        KSecurityKeys.firebaseAppCheckDev,
      ),
      androidProvider: Config.isReleaseMode
          ? AndroidProvider.playIntegrity
          : AndroidProvider.debug,
      appleProvider: Config.isReleaseMode
          ? AppleProvider.deviceCheck
          : AppleProvider.debug,
    );
  } catch (e) {}

  // Non-async exceptions
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);

    return true;
  };
  // }

  // try {
  // if (Config.isWeb) {
  //   await FirebasePerformance.instanceFor(app: app)
  //       .setPerformanceCollectionEnabled(Config.isReleaseMode);
  // } else {
  //   await FirebasePerformance.instance
  //       .setPerformanceCollectionEnabled(Config.isReleaseMode);
  // }
  // } catch (e, stack) {
  //   print('firebase performance issue');
  //   print(e);
  // }
  // try {
  // if (!Config.isWeb) {
  //   // {
  //   //   final temp = await FirebaseAppCheck.instanceFor(app: app).activate(
  //   //     webProvider: ReCaptchaV3Provider(Config.isReleaseMode
  //   //         ? 'REDACTED'
  //   //         : '4A104621-0F8F-4D82-A07F-008910737512'),
  //   //   );
  //   // } else {
  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider:
  //         Config.isReleaseMode ? AndroidProvider.playIntegrity :
  // AndroidProvider.debug,
  //     appleProvider: Config.isReleaseMode
  //         ? AppleProvider.appAttestWithDeviceCheckFallback
  //         : AppleProvider.debug,
  //   );
  // }
  // } catch (e, stack) {
  //   print('firebase app check issue');
  //   print(e);
  // }

  // Non-async exceptions
  // FlutterError.onError = (details) {
  //   if (Config.isWeb) {
  //     Sentry.captureException(
  //       details.exceptionAsString(),
  //       stackTrace: details.stack,
  //     );
  //   } else {
  //     FirebaseCrashlytics.instance.recordFlutterError(details);
  //   }
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };
  // Async exceptions
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   if (Config.isWeb) {
  //     Sentry.captureException(
  //       error,
  //       stackTrace: stack,
  //     );
  //   } else {
  //     FirebaseCrashlytics.instance.recordError(error, stack);
  //   }
  //   log(error.toString(), stackTrace: stack);

  //   return true;
  // };

  await bootstrap(App.new);
}

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_development.dart';

/// COMMENT: DEV main file
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final app =
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kReleaseMode) {
    await FirebaseAppCheck.instanceFor(app: app).activate(
      webProvider: ReCaptchaV3Provider(
        'REDACTED',
      ),
    );

    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider(
        'REDACTED',
      ),
    );
  }

  // try {
  // if (kIsWeb) {
  //   await FirebasePerformance.instanceFor(app: app)
  //       .setPerformanceCollectionEnabled(kReleaseMode);
  // } else {
  //   await FirebasePerformance.instance
  //       .setPerformanceCollectionEnabled(kReleaseMode);
  // }
  // } catch (e, stack) {
  //   print('firebase performance issue');
  //   print(e);
  // }
  // try {
  // if (!kIsWeb) {
  //   // {
  //   //   final temp = await FirebaseAppCheck.instanceFor(app: app).activate(
  //   //     webProvider: ReCaptchaV3Provider(kReleaseMode
  //   //         ? 'REDACTED'
  //   //         : '4A104621-0F8F-4D82-A07F-008910737512'),
  //   //   );
  //   // } else {
  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider:
  //         kReleaseMode ? AndroidProvider.playIntegrity :
  // AndroidProvider.debug,
  //     appleProvider: kReleaseMode
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
  //   if (kIsWeb) {
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
  //   if (kIsWeb) {
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

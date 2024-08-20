import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:veteranam/app.dart';
import 'package:veteranam/bootstrap.dart';
import 'package:veteranam/firebase_options_production.dart';

/// COMMENT: PROD main file
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  await FirebaseAppCheck.instance.activate();

  if (kIsWeb) {
    await SentryFlutter.init(
      (options) {
        options
          ..dsn =
              'REDACTED'
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

  await bootstrap(App.new);
}

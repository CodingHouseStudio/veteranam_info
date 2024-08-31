import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:veteranam/shared/shared.dart';

@LazySingleton(order: -2)
class FailureRepository {
  FailureRepository(this.firebaseCrashlytics);

  final FirebaseCrashlytics firebaseCrashlytics;
  void sendError(SomeFailure failure) {
    if (KTest.isTest) return;
    final error = failure.error;
    final stack = failure.stack;
    if (error != null) {
      if (kReleaseMode && Config.isProduction) {
        if (kIsWeb) {
          Sentry.captureException(
            error,
            stackTrace: stack,
          );
        } else {
          FirebaseCrashlytics.instance.recordError(error, stack);
        }
      } else {
        debugPrint('EXCEPTION: $error \n EXCEPTION STACK: $stack');
      }
    }
  }
}

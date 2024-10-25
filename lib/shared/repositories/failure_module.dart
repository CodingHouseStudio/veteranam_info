import 'package:firebase_crashlytics/firebase_crashlytics.dart'
    show FirebaseCrashlytics;
import 'package:injectable/injectable.dart';

@module
abstract class FailureModule {
  @Singleton(order: -3)
  FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;
}

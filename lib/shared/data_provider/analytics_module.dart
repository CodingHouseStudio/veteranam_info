import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AnalytucsModule {
  @singleton
  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;
}

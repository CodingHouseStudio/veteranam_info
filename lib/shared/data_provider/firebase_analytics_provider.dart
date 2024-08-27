import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@singleton
class FirebaseAnalyticsService {
  FirebaseAnalyticsService(
    this._firebaseAnalytics,
  );

  final FirebaseAnalytics _firebaseAnalytics;

  void addEvent({
    required String name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) {
    if (kReleaseMode && Config.isProduction) {
      unawaited(
        _firebaseAnalytics.logEvent(
          name: name,
          callOptions: callOptions,
          parameters: parameters,
        ),
      );
    }
  }
}

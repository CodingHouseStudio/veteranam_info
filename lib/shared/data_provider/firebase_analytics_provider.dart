import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@singleton
class FirebaseAnalyticsService {
  FirebaseAnalyticsService(
    this._firebaseAnalytics,
    this._authenticationRepository,
  ) {
    _initUserId();
  }

  final FirebaseAnalytics _firebaseAnalytics;
  final AuthenticationRepository _authenticationRepository;

  void _initUserId() {
    // Add user properties when we'll add login and sign up page
    if (kReleaseMode && Config.isProduction) {
      try {
        unawaited(
          _firebaseAnalytics.setUserId(
            id: _authenticationRepository.currentUser.id,
            callOptions: AnalyticsCallOptions(global: true),
          ),
        );
        unawaited(
          _firebaseAnalytics.setUserProperty(
            name: 'Language',
            value: _authenticationRepository.currentUserSetting.locale.text,
          ),
        );
      } catch (e) {
        // unawaited(
        //   _firebaseAnalytics.setUserId(
        //     id: User.empty.id,
        //     callOptions: AnalyticsCallOptions(global: true),
        //   ),
        // );
        // unawaited(
        //   _firebaseAnalytics.setUserProperty(
        //     name: 'Language',
        //     value: UserSetting.empty.locale.text,
        //   ),
        // );
      }
    }
  }

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

import 'dart:async' show unawaited;
import 'dart:developer';

import 'package:app_tracking_transparency/app_tracking_transparency.dart'
    show AppTrackingTransparency, TrackingStatus;
import 'package:dartz/dartz.dart';
import 'package:firebase_analytics/firebase_analytics.dart'
    show AnalyticsCallOptions, FirebaseAnalytics;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@singleton
class FirebaseAnalyticsService {
  FirebaseAnalyticsService({
    required FirebaseAnalytics firebaseAnalytics,
    required UserRepository userRepository,
    required FirebaseAnalyticsCacheController firebaseAnalyticsCacheController,
  })  : _userRepository = userRepository,
        _firebaseAnalytics = firebaseAnalytics,
        _firebaseAnalyticsCacheController = firebaseAnalyticsCacheController {
    initUserId();
  }

  final FirebaseAnalytics _firebaseAnalytics;
  final UserRepository _userRepository;
  final FirebaseAnalyticsCacheController _firebaseAnalyticsCacheController;
  bool _userConsentGranted = false;

  Future<void> initUserId() async {
    // Add user properties when we'll add login and sign up page
    if (Config.isReleaseMode &&
        Config.isProduction &&
        _firebaseAnalyticsCacheController.currentState) {
      // Check if platform is iOS and request
      // app tracking transparency permission
      // if (!Config.isWeb) {
      if (PlatformEnum.getPlatform.isIOS) {
        // Check if user has granted consent
        final trackingStatus =
            await AppTrackingTransparency.trackingAuthorizationStatus;

        // If not determined, request authorization
        if (trackingStatus == TrackingStatus.authorized) {
          _userConsentGranted = true;
          await setConsent(state: true, isIOS: true);
        }
      } else {
        // For platforms other than iOS, assume
        // consent is granted (or adjust based on your policy)
        _userConsentGranted = true;
      }

      if (_userConsentGranted) {
        try {
          unawaited(
            _firebaseAnalytics.setUserId(
              id: _userRepository.currentUser.id,
              callOptions: AnalyticsCallOptions(global: true),
            ),
          );
          unawaited(
            _firebaseAnalytics.setUserProperty(
              name: 'Language',
              value: _userRepository.currentUserSetting.locale.text,
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
      // }
    }
  }

  Future<Either<SomeFailure, bool>> setConsent({
    required bool state,
    bool isIOS = false,
  }) async =>
      eitherFutureHelper(
        () async {
          await _firebaseAnalytics.setConsent(
            analyticsStorageConsentGranted: state,
            functionalityStorageConsentGranted: state,
            securityStorageConsentGranted: state,
          );
          if (!isIOS) {
            await _firebaseAnalyticsCacheController.setConsent(state: state);
            unawaited(
              initUserId(),
            );
          }
          return const Right(true);
        },
        methodName: 'setConsent',
        className: 'Firebase Analytics Service',
      );

  void addEvent({
    required String? name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) {
    try {
      if (Config.isReleaseMode &&
          Config.isProduction &&
          name != null &&
          _userConsentGranted &&
          _firebaseAnalyticsCacheController.currentState) {
        unawaited(
          _firebaseAnalytics.logEvent(
            name: name,
            callOptions: callOptions,
            parameters: parameters,
          ),
        );
      }
    } catch (e, stack) {
      log(
        'Firebase Analytics error: ',
        error: e,
        stackTrace: stack,
      );
    }
  }
}

import 'dart:async' show unawaited;

import 'package:app_tracking_transparency/app_tracking_transparency.dart'
    show AppTrackingTransparency, TrackingStatus;
import 'package:firebase_analytics/firebase_analytics.dart'
    show AnalyticsCallOptions, FirebaseAnalytics;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@singleton
class FirebaseAnalyticsService {
  FirebaseAnalyticsService(
    this._firebaseAnalytics,
    this._userRepository,
  ) {
    _initUserId();
  }

  final FirebaseAnalytics _firebaseAnalytics;
  final UserRepository _userRepository;
  bool _userConsentGranted = false;

  Future<void> _initUserId() async {
    // Add user properties when we'll add login and sign up page
    if (Config.isReleaseMode && Config.isProduction) {
      // Check if platform is iOS and request
      // app tracking transparency permission
      if (!Config.isWeb) {
        if (PlatformEnum.getPlatform.isIOS) {
          // Check if user has granted consent
          final trackingStatus =
              await AppTrackingTransparency.trackingAuthorizationStatus;

          // If not determined, request authorization
          if (trackingStatus == TrackingStatus.authorized) {
            _userConsentGranted = true;
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
      }
    }
  }

  void addEvent({
    required String? name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) {
    if (Config.isReleaseMode &&
        Config.isProduction &&
        name != null &&
        _userConsentGranted) {
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

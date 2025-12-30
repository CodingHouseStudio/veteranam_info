import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;

import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

@singleton
class FirebaseAnalyticsCacheController {
  FirebaseAnalyticsCacheController({
    required SharedPrefencesProvider sharedPrefencesProvider,
  }) : _sharedPrefencesProvider = sharedPrefencesProvider;

  final SharedPrefencesProvider _sharedPrefencesProvider;

  @visibleForTesting
  static const consentDialogShowedKey =
      '__firebase_analytics_consent_dialog_showed_key__';

  @visibleForTesting
  static const analyticsAgreeddKey = '__analytics_agreed_key__';

  bool get consentDialogShowed =>
      _sharedPrefencesProvider.getBool(consentDialogShowedKey) ?? false;

  bool get currentState {
    final anaylticsAgreed =
        _sharedPrefencesProvider.getBool(analyticsAgreeddKey);
    return PlatformEnum.getPlatform.isIOS || (anaylticsAgreed ?? false);
  }

  Future<void> setConsent({required bool state}) async {
    await _sharedPrefencesProvider.setBool(
      key: consentDialogShowedKey,
      value: true,
    );
    await _sharedPrefencesProvider.setBool(
      key: analyticsAgreeddKey,
      value: state,
    );
  }
}

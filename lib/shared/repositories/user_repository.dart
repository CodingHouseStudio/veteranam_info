import 'dart:async';
import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@singleton
class UserRepository {
  UserRepository({
    required IAppAuthenticationRepository appAuthenticationRepository,
    required ISharedPrefencesRepository sharedPrefencesRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        _sharedPrefencesRepository = sharedPrefencesRepository {
    _userSettingController = StreamController<UserSetting>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
    _userController = StreamController<User>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
  }
  final IAppAuthenticationRepository _appAuthenticationRepository;
  final ISharedPrefencesRepository _sharedPrefencesRepository;

  @visibleForTesting
  static const userLanguageKey = '__user_language_key__';

  late StreamController<UserSetting> _userSettingController;
  late StreamController<User> _userController;
  StreamSubscription<User>? _userSubscription;
  StreamSubscription<UserSetting>? _userSettingSubscription;

  void _onUserStreamListen() {
    getUserLanguageFromCash();
    _userSubscription ??=
        _appAuthenticationRepository.user.listen((currentUser) {
      if (currentUser.isNotEmpty) {
        _userController.add(
          currentUser,
        );
        if (currentUserSetting.id != currentUser.id &&
            _userSettingSubscription != null) {
          _userSettingSubscription?.cancel();
          _userSettingSubscription = null;
        }
        var userSettingIsNew = _userSettingSubscription == null;
        _userSettingSubscription ??=
            _appAuthenticationRepository.userSetting.listen(
          (currentUserSettingValue) {
            if (userSettingIsNew) {
              _createFcmUserSettingAndRemoveDeleteParameter();
              userSettingIsNew = false;
            }
            _userSettingController.add(
              currentUserSettingValue,
            );
          },
        );
      } else {
        _userSettingSubscription?.cancel();
        _userSettingSubscription = null;
      }
    });
  }

  Future<void> getUserLanguageFromCash() async {
    await _sharedPrefencesRepository.initWait();
    final languageCode = _sharedPrefencesRepository.getString(userLanguageKey);
    if (languageCode != null && !currentUserSetting.locale.isEnglish) {
      final language = Language.getFromLanguageCode(languageCode);
      if (language != Language.ukrain) {
        _userSettingController
            .add(currentUserSetting.copyWith(locale: language));
      }
    }
  }

  void _onUserStreamCancel() {
    _userSettingSubscription?.cancel();
    _userSubscription?.cancel();
    _userSettingSubscription = null;
    _userSubscription = null;
  }

  Stream<UserSetting> get userSetting => _userSettingController.stream;
  Stream<User> get user => _userController.stream;

  User get currentUser {
    return _appAuthenticationRepository.currentUser;
  }

  UserSetting get currentUserSetting {
    return _appAuthenticationRepository.currentUserSetting;
  }

  Future<void> _createFcmUserSettingAndRemoveDeleteParameter() async {
    final result = await _appAuthenticationRepository
        .createFcmUserSettingAndRemoveDeletePameter();
    result.fold(
      (l) {},
      (r) {
        log('created FCM TOKEN', name: 'FCM Token', level: 1);
      },
    );
  }

  Future<Either<SomeFailure, bool>> updateUserSetting({
    required UserSetting userSetting,
  }) async {
    if (userSetting.locale != currentUserSetting.locale) {
      unawaited(
        _sharedPrefencesRepository.setString(
          key: userLanguageKey,
          value: userSetting.locale.value.languageCode,
        ),
      );
    }
    final result =
        await _appAuthenticationRepository.updateUserSetting(userSetting);
    return result.fold(
      Left.new,
      (success) {
        _userSettingController.add(success);
        log('User Setting Updated, new is $success', name: 'User Setting');
        return const Right(true);
      },
    );
  }

  Future<Either<SomeFailure, bool>> updateUserData({
    required User user,
    required String? nickname,
    required FilePickerItem? image,
  }) async {
    SomeFailure? failureValue;

    if (image != null || user.name != currentUser.name) {
      final result = await _appAuthenticationRepository.updateUserData(
        user: user,
        image: image,
      );

      result.fold(
        (failure) {
          failureValue = failure;
        },
        (success) {
          _userController.add(success);
          log('Sending succeses $userSetting');
        },
      );
    }
    if (nickname != currentUserSetting.nickname) {
      final result = await updateUserSetting(
        userSetting: currentUserSetting.copyWith(nickname: nickname),
      );

      result.fold(
        (failure) {
          failureValue = failure;
        },
        (success) {
          log('User Setting Updated, new is $success', name: 'User Setting');
        },
      );
    }

    if (failureValue != null) {
      return Left(failureValue!);
    } else {
      return const Right(true);
    }
  }

  bool get isEnglish => currentUserSetting.locale.isEnglish;

  // @disposeMethod
  void dispose() {
    _userController.close();
    _userSubscription?.cancel();

    _userSettingController.close();
    _userSettingSubscription?.cancel();
  }
}

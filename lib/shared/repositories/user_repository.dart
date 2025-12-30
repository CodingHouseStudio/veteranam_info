import 'dart:async';
import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

@singleton
class UserRepository {
  UserRepository({
    required IAppAuthenticationRepository appAuthenticationRepository,
    required ILanguageCacheRepository languageCacheRepository,
    required IDeviceRepository deviceRepository,
  })  : _appAuthenticationRepository = appAuthenticationRepository,
        _languageCacheRepository = languageCacheRepository,
        _deviceRepository = deviceRepository {
    _userController = StreamController<User>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserStreamCancel,
    );
    _userSettingController = StreamController<UserSetting>.broadcast(
      onListen: _onUserStreamListen,
      onCancel: _onUserSettingStreamCancel,
    );
  }
  final IAppAuthenticationRepository _appAuthenticationRepository;
  final ILanguageCacheRepository _languageCacheRepository;
  final IDeviceRepository _deviceRepository;

  late StreamController<UserSetting> _userSettingController;
  late StreamController<User> _userController;
  StreamSubscription<User>? _userSubscription;
  StreamSubscription<UserSetting>? _userSettingSubscription;

  void _onUserStreamListen() {
    tryGetUserLanguageFromCache();
    _userSubscription ??=
        _appAuthenticationRepository.user.listen((currentUser) async {
      if (currentUser.isNotEmpty) {
        _userController.add(
          currentUser,
        );
        if (currentUserSetting.id != currentUser.id &&
            _userSettingSubscription != null) {
          await _userSettingSubscription?.cancel();
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
        await _userSettingSubscription?.cancel();
        _userSettingSubscription = null;
      }
    });
  }

  void tryGetUserLanguageFromCache() {
    final cacheLanguage = _languageCacheRepository.getFromCache;
    if (cacheLanguage != null) {
      _userSettingController.add(
        currentUserSetting.copyWith(
          locale: cacheLanguage,
        ),
      );
    }
  }

  void _onUserStreamCancel() {
    _userSubscription?.cancel();
    _userSubscription = null;
  }

  void _onUserSettingStreamCancel() {
    _userSettingSubscription?.cancel();
    _userSettingSubscription = null;
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
    final result = await _deviceRepository.getDevice();

    return result.fold(
      Left.new,
      (r) async {
        var userSetting = currentUserSetting;
        if (currentUserSetting.deletedOn != null) {
          userSetting = userSetting.copyWith(deletedOn: null);
        }
        if (r != null) {
          final devicesInfo =
              List<DeviceInfoModel>.of(currentUserSetting.devicesInfo ?? []);
          if (r.fcmToken != null) {
            devicesInfo
              ..removeWhere(
                (deviceInfo) => deviceInfo.deviceId == r.deviceId,
              )
              ..add(r);
          }
          userSetting = userSetting.copyWith(
            id: currentUser.id,
            devicesInfo: devicesInfo,
          );
        }
        if (userSetting != currentUserSetting) {
          await updateUserSetting(userSetting: userSetting);
        }
      },
    );
  }

  Future<Either<SomeFailure, bool>> updateUserSetting({
    required UserSetting userSetting,
  }) async {
    _languageCacheRepository.saveToCache(
      language: userSetting.locale,
      previousLanguage: currentUserSetting.locale,
    );
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
  Future<void> dispose() async {
    await _userController.close();

    await _userSettingController.close();
  }
}

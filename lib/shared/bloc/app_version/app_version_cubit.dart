import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

part 'app_version_state.dart';

@injectable
class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit({
    required AppInfoRepository buildRepository,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
  })  : _buildRepository = buildRepository,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        super(
          AppVersionState(
            build: AppInfoRepository.defaultValue,
            mobHasNewBuild: false,
          ),
        );
  final AppInfoRepository _buildRepository;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;
  Timer? _delay;

  @visibleForTesting
  static const mobAppVersionKey = '__mob_app_version_key__';

  Future<void> started() async {
    final buildInfo = await _buildRepository.getBuildInfo();
    var mobAppVersion =
        _firebaseRemoteConfigProvider.getString(mobAppVersionKey);
    if (mobAppVersion.isEmpty) {
      _delay = Timer(Duration(seconds: KTest.isTest ? 0 : 5), () {
        mobAppVersion =
            _firebaseRemoteConfigProvider.getString(mobAppVersionKey);
        _setData(mobAppVersion: mobAppVersion, buildInfo: buildInfo);
      });
    } else {
      _setData(mobAppVersion: mobAppVersion, buildInfo: buildInfo);
    }
  }

  void _setData({
    required String mobAppVersion,
    required PackageInfo buildInfo,
  }) {
    var mobHasNewBuild = false;
    if (KTest.testReleaseMode) {
      try {
        final currentVersion = buildInfo.version.split('.');
        final configVersion = mobAppVersion.split('.');

        for (var i = 0; i < configVersion.length; i++) {
          if ((int.parse(configVersion[i])) > (int.parse(currentVersion[i]))) {
            mobHasNewBuild = true;
            break;
          }
        }
      } catch (e) {
        mobHasNewBuild = buildInfo.version != mobAppVersion;
      }
    }
    emit(
      AppVersionState(
        build: buildInfo,
        mobHasNewBuild: mobHasNewBuild,
      ),
    );
  }

  @override
  Future<void> close() {
    _delay?.cancel();
    _delay = null;
    return super.close();
  }
}

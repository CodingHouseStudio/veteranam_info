import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart'
    show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared_dart.dart';

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
        ) {
    _started();
  }
  final AppInfoRepository _buildRepository;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;

  @visibleForTesting
  static const mobAppVersionKey = '__mob_app_version_key__';

  Future<void> _started() async {
    final buildInfo = await _buildRepository.getBuildInfo();

    emit(
      AppVersionState(
        build: buildInfo,
        mobHasNewBuild: false,
      ),
    );

    // Wait for initialize remote config if it didn't happen yet
    await _firebaseRemoteConfigProvider.waitActivated();

    final mobAppVersion =
        _firebaseRemoteConfigProvider.getString(mobAppVersionKey);
    _setData(mobAppVersion: mobAppVersion, buildInfo: buildInfo);
  }

  void _setData({
    required String mobAppVersion,
    required PackageInfo buildInfo,
  }) {
    var mobHasNewBuild = false;
    if (Config.isReleaseMode) {
      try {
        final configVersion = _parseVersionToInt(mobAppVersion);
        final currentVersion = _parseVersionToInt(buildInfo.version);
        mobHasNewBuild = configVersion > currentVersion;
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

  /// Parse version for example if we have 0.2.0 this method parse it to 20
  int _parseVersionToInt(String version) =>
      int.parse(version.replaceAll('.', ''));
}

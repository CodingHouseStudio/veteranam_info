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

  @visibleForTesting
  static const mobAppVersionKey = '__mob_app_version_key__';

  Future<void> started() async {
    final buildInfo = await _buildRepository.getBuildInfo();
    final mobLastBuild =
        _firebaseRemoteConfigProvider.getString(mobAppVersionKey);
    emit(
      AppVersionState(
        build: buildInfo,
        mobHasNewBuild:
            KTest.testReleaseMode && buildInfo.buildNumber != mobLastBuild,
      ),
    );
  }
}

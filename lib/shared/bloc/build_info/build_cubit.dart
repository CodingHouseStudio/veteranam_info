import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:veteranam/shared/shared.dart';

part 'buid_state.dart';

@injectable
class BuildCubit extends Cubit<BuildState> {
  BuildCubit({
    required BuildRepository buildRepository,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
  })  : _buildRepository = buildRepository,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        super(
          BuildState(
            build: BuildRepository.defaultValue,
            mobHasNewBuild: false,
          ),
        );
  final BuildRepository _buildRepository;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;

  @visibleForTesting
  static const mobBuildKey = '__mob_build_key__';

  Future<void> started() async {
    final buildInfo = await _buildRepository.getBuildInfo();
    final mobLastBuild = _firebaseRemoteConfigProvider.getString(mobBuildKey);
    emit(
      BuildState(
        build: buildInfo,
        mobHasNewBuild:
            KTest.testReleaseMode && buildInfo.buildNumber != mobLastBuild,
      ),
    );
  }
}

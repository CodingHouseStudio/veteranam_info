import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.build} ${KGroupText.cubit}', () {
    late AppVersionCubit buildCubit;
    late AppInfoRepository mockBuildRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

    setUp(() {
      mockBuildRepository = MockAppInfoRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      when(
        mockBuildRepository.getBuildInfo(),
      ).thenAnswer(
        (_) async => AppInfoRepository.defaultValue,
      );
      buildCubit = AppVersionCubit(
        buildRepository: mockBuildRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      );
    });
    blocTest<AppVersionCubit, AppVersionState>(
      'emits [PackageInfo()] when initial',
      build: () => buildCubit,
      act: (bloc) async {
        await bloc.started();
        when(
          mockFirebaseRemoteConfigProvider
              .getString(AppVersionCubit.mobAppVersionKey),
        ).thenAnswer(
          (_) => KTestText.build,
        );
      },
      expect: () async => [
        AppVersionState(
          build: AppInfoRepository.defaultValue,
          mobHasNewBuild: true,
        ),
      ],
    );
    blocTest<AppVersionCubit, AppVersionState>(
      'emits [PackageInfo()] when initial and config empty',
      build: () => buildCubit,
      act: (bloc) async {
        when(
          mockFirebaseRemoteConfigProvider
              .getString(AppVersionCubit.mobAppVersionKey),
        ).thenAnswer(
          (_) => '',
        );
        await bloc.started();
      },
      expect: () async => [
        AppVersionState(
          build: AppInfoRepository.defaultValue,
          mobHasNewBuild: true,
        ),
      ],
    );
  });
}

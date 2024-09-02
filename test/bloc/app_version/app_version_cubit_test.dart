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
      when(
        mockFirebaseRemoteConfigProvider
            .getString(AppVersionCubit.mobAppVersionKey),
      ).thenAnswer(
        (_) => KTestText.build,
      );
      buildCubit = AppVersionCubit(
        buildRepository: mockBuildRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      );
    });
    blocTest<AppVersionCubit, AppVersionState>(
      'emits [PackageInfo()] when initial',
      build: () => buildCubit,
      act: (bloc) async => bloc.started(),
      expect: () async => [
        AppVersionState(
          build: AppInfoRepository.defaultValue,
          mobHasNewBuild: true,
        ),
      ],
    );
  });
}

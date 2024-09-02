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
    late BuildCubit buildCubit;
    late BuildRepository mockBuildRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

    setUp(() {
      mockBuildRepository = MockBuildRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      when(
        mockBuildRepository.getBuildInfo(),
      ).thenAnswer(
        (_) async => BuildRepository.defaultValue,
      );
      when(
        mockFirebaseRemoteConfigProvider.getString(BuildCubit.mobBuildKey),
      ).thenAnswer(
        (_) => KTestText.build,
      );
      buildCubit = BuildCubit(
        buildRepository: mockBuildRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      );
    });
    blocTest<BuildCubit, BuildState>(
      'emits [PackageInfo()] when initial',
      build: () => buildCubit,
      act: (bloc) async => bloc.started(),
      expect: () async => [
        BuildState(build: BuildRepository.defaultValue, mobHasNewBuild: true),
      ],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.build} ${KGroupText.cubit}', () {
    // late AppVersionCubit buildCubit;
    late AppInfoRepository mockBuildRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

    setUp(() {
      mockBuildRepository = MockAppInfoRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      when(
        mockFirebaseRemoteConfigProvider.waitActivated(),
      ).thenAnswer(
        (_) async => true,
      );
      when(
        mockBuildRepository.getBuildInfo(),
      ).thenAnswer(
        (_) async => AppInfoRepository.defaultValue,
      );
    });
    group('emits [PackageInfo()] when initial', () {
      setUp(
        () {
          when(
            mockFirebaseRemoteConfigProvider
                .getString(AppVersionCubit.mobAppVersionKey),
          ).thenAnswer(
            (_) => KTestVariables.build,
          );
        },
      );
      blocTest<AppVersionCubit, AppVersionState>(
        'Bloc Test',
        build: () => AppVersionCubit(
          buildRepository: mockBuildRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        // act: (bloc) async {},
        expect: () async => [
          AppVersionState(
            build: AppInfoRepository.defaultValue,
            mobHasNewBuild: false,
          ),
          AppVersionState(
            build: AppInfoRepository.defaultValue,
            mobHasNewBuild: true,
          ),
        ],
      );
    });
    group('emits [PackageInfo()] when initial equale version', () {
      setUp(
        () {
          when(
            mockFirebaseRemoteConfigProvider
                .getString(AppVersionCubit.mobAppVersionKey),
          ).thenAnswer(
            (_) => KTestVariables.version,
          );
          when(
            mockBuildRepository.getBuildInfo(),
          ).thenAnswer(
            (_) async => KTestVariables.packageInfo,
          );
        },
      );
      blocTest<AppVersionCubit, AppVersionState>(
        'Bloc Test',
        build: () => AppVersionCubit(
          buildRepository: mockBuildRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        // act: (bloc) async {
        //   // await bloc.started();
        // },
        expect: () async => [
          AppVersionState(
            build: KTestVariables.packageInfo,
            mobHasNewBuild: false,
          ),
        ],
      );
    });

    group('emits [PackageInfo()] when initial config version low', () {
      setUp(
        () {
          when(
            mockFirebaseRemoteConfigProvider
                .getString(AppVersionCubit.mobAppVersionKey),
          ).thenAnswer(
            (_) => KTestVariables.oldVersion,
          );
          when(
            mockBuildRepository.getBuildInfo(),
          ).thenAnswer(
            (_) async => KTestVariables.packageInfo,
          );
          // buildCubit = AppVersionCubit(
          //   buildRepository: mockBuildRepository,
          //   firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
          // );
        },
      );
      blocTest<AppVersionCubit, AppVersionState>(
        'Bloc Test',
        build: () => AppVersionCubit(
          buildRepository: mockBuildRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        // act: (bloc) async {
        //   // await bloc.started();
        // },
        expect: () async => [
          AppVersionState(
            build: KTestVariables.packageInfo,
            mobHasNewBuild: false,
          ),
        ],
      );
    });

    group('emits [PackageInfo()] when initial and config empty', () {
      setUp(
        () {
          when(
            mockFirebaseRemoteConfigProvider
                .getString(AppVersionCubit.mobAppVersionKey),
          ).thenAnswer(
            (_) => '',
          );
        },
      );
      blocTest<AppVersionCubit, AppVersionState>(
        'Bloc Test',
        build: () => AppVersionCubit(
          buildRepository: mockBuildRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        act: (bloc) async {
          // await bloc.started();
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<AppVersionState>(
                (state) => state.build == AppInfoRepository.defaultValue,
              ),
            ]),
            reason: 'Wait loading data',
          );
        },
        expect: () async => [
          AppVersionState(
            build: AppInfoRepository.defaultValue,
            mobHasNewBuild: false,
          ),
          AppVersionState(
            build: AppInfoRepository.defaultValue,
            mobHasNewBuild: true,
          ),
        ],
      );
    });
  });
}

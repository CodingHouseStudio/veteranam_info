import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void mobBuild() {
  final AppInfoRepository mockBuildRepository = MockAppInfoRepository();
  final FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider =
      MockFirebaseRemoteConfigProvider();

  when(
    mockBuildRepository.getBuildInfo(),
  ).thenAnswer((realInvocation) async => AppInfoRepository.defaultValue);

  when(
    mockFirebaseRemoteConfigProvider.waitActivated(),
  ).thenAnswer(
    (_) async => true,
  );
  when(
    mockFirebaseRemoteConfigProvider
        .getString(AppVersionCubit.mobAppVersionKey),
  ).thenAnswer(
    (_) => AppInfoRepository.defaultValue.buildNumber,
  );

  final buildCubit = AppVersionCubit(
    buildRepository: mockBuildRepository,
    firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (GetIt.I.isRegistered<AppVersionCubit>()) {
    GetIt.I.unregister<AppVersionCubit>();
  }
  GetIt.I.registerSingleton<AppVersionCubit>(buildCubit);
}

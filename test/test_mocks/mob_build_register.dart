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

  registerSingleton(mockFirebaseRemoteConfigProvider);
  registerSingleton(mockBuildRepository);
}

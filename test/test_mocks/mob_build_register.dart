import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void mobBuild() {
  final BuildRepository mockBuildRepository = MockBuildRepository();
  final FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider =
      MockFirebaseRemoteConfigProvider();

  when(
    mockBuildRepository.getBuildInfo(),
  ).thenAnswer((realInvocation) async => BuildRepository.defaultValue);

  when(
    mockFirebaseRemoteConfigProvider.getString(BuildCubit.mobBuildKey),
  ).thenAnswer(
    (_) => BuildRepository.defaultValue.buildNumber,
  );

  final buildCubit = BuildCubit(
    buildRepository: mockBuildRepository,
    firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
  );
  if (GetIt.I.isRegistered<BuildCubit>()) {
    GetIt.I.unregister<BuildCubit>();
  }
  GetIt.I.registerSingleton<BuildCubit>(buildCubit);
}

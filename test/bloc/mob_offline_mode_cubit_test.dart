import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.url} ${KGroupText.cubit}', () {
    late MobOfflineModeCubit mobOfflineModeCubit;
    late FirestoreService mockFirestoreService;
    late CacheClient mockCache;

    setUp(() {
      mockCache = MockCacheClient();
      when(
        mockCache.write(
          key: FirestoreService.offlineModeCacheKey,
          value: MobMode.online,
        ),
      ).thenAnswer(
        (_) {},
      );
      when(
        mockCache.write(
          key: FirestoreService.offlineModeCacheKey,
          value: MobMode.offline,
        ),
      ).thenAnswer(
        (_) {},
      );
      mockFirestoreService = FirestoreService(mockCache);
      mobOfflineModeCubit = MobOfflineModeCubit(
        firestoreService: mockFirestoreService,
      );
    });
    blocTest<MobOfflineModeCubit, MobMode>(
      'emits [MobMode()]'
      ' when initial and switch mode',
      build: () => mobOfflineModeCubit,
      act: (bloc) async => bloc
        ..started()
        ..switchMode()
        ..switchMode(),
      expect: () async => [
        MobMode.offline,
        MobMode.online,
        MobMode.offline,
      ],
    );
  });
}

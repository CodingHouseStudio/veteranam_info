import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.authenticationServices} ${KGroupText.cubit}', () {
    late FirebaseAnalyticsService mockFirebaseAnalyticsService;
    late CookiesDialogCubit cookiesDialogCubit;
    setUp(() {
      mockFirebaseAnalyticsService = MockFirebaseAnalyticsService();
      cookiesDialogCubit = CookiesDialogCubit(
        firebaseAnalyticsService: mockFirebaseAnalyticsService,
      );
    });
    blocTest<CookiesDialogCubit, bool>(
      'emits [bool] submit wuth onlyNecessary false',
      build: () => cookiesDialogCubit,
      act: (cubit) async {
        when(
          mockFirebaseAnalyticsService.setConsent(state: true),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        cubit.submitted(onlyNecessary: false);
      },
      expect: () async => [
        true,
      ],
    );
    blocTest<CookiesDialogCubit, bool>(
      'emits [bool] submit wuth onlyNecessary true',
      build: () => cookiesDialogCubit,
      act: (cubit) async {
        when(
          mockFirebaseAnalyticsService.setConsent(state: false),
        ).thenAnswer(
          (_) async => const Right(true),
        );
        cubit.submitted(onlyNecessary: true);
      },
      expect: () async => [
        true,
      ],
    );
    blocTest<CookiesDialogCubit, bool>(
      'emits [bool] submit failure',
      build: () => cookiesDialogCubit,
      act: (cubit) async {
        when(
          mockFirebaseAnalyticsService.setConsent(state: false),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );
        cubit.submitted(onlyNecessary: true);
      },
      expect: () async => [
        true,
      ],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
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
  group('${KScreenBlocName.url} ', () {
    late MobileRatingCubit mobileRatingCubit;
    late MobileRatingRepository mockMobileRatingRepository;

    setUp(() {
      mockMobileRatingRepository = MockMobileRatingRepository();
      mobileRatingCubit = MobileRatingCubit(
        mobileRatingRepository: mockMobileRatingRepository,
      );
    });

    blocTest<MobileRatingCubit, void>(
      'when show rating dialog correct',
      build: () => mobileRatingCubit,
      act: (bloc) async {
        when(mockMobileRatingRepository.showRatingDialog()).thenAnswer(
          (invocation) async => const Right(true),
        );
        await bloc.showDialog();
      },
      expect: () async => <void>[],
    );

    blocTest<MobileRatingCubit, void>(
      'when show rating dialog failure',
      build: () => mobileRatingCubit,
      act: (bloc) async {
        when(mockMobileRatingRepository.showRatingDialog()).thenAnswer(
          (invocation) async => const Right(true),
        );
        await bloc.showDialog();
      },
      expect: () async => <void>[],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.home} ${KGroupText.bloc}', () {
    late HomeWatcherBloc homeWatcherBloc;
    late IHomeRepository mockHomeRepository;
    setUp(() {
      mockHomeRepository = MockIHomeRepository();
      homeWatcherBloc = HomeWatcherBloc(
        homeRepository: mockHomeRepository,
      );
    });

    blocTest<HomeWatcherBloc, HomeWatcherState>(
      'emits [HomeWatcherState.loading(), HomeWatcherState.success()]'
      ' when load questionModel list',
      build: () => homeWatcherBloc,
      act: (bloc) async {
        when(mockHomeRepository.getQuestions()).thenAnswer(
          (_) async => Right(KTestText.questionModelItems),
        );
        bloc.add(const HomeWatcherEvent.started());
      },
      expect: () async => [
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
    blocTest<HomeWatcherBloc, HomeWatcherState>(
      'emits [HomeWatcherState.faulure()] when error',
      build: () => homeWatcherBloc,
      act: (bloc) async {
        when(mockHomeRepository.getQuestions()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError()),
        );
        bloc.add(const HomeWatcherEvent.started());
      },
      expect: () async => [
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.error,
        ),
      ],
    );
  });
}

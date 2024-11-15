import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.home} ${KGroupText.bloc}', () {
    late HomeWatcherBloc homeWatcherBloc;
    late IFaqRepository mockFaqRepository;
    setUp(() {
      mockFaqRepository = MockIFaqRepository();
      homeWatcherBloc = HomeWatcherBloc(
        faqRepository: mockFaqRepository,
      );
    });

    blocTest<HomeWatcherBloc, HomeWatcherState>(
      'emits [HomeWatcherState.loading(), HomeWatcherState.success()]'
      ' when load questionModel list',
      build: () => homeWatcherBloc,
      act: (bloc) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (_) async => Right(KTestText.questionModelItems),
        );
        bloc.add(const HomeWatcherEvent.started());
      },
      expect: () async => [
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatusHome.loading,
        ),
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatusHome.loaded,
        ),
      ],
    );
    blocTest<HomeWatcherBloc, HomeWatcherState>(
      'emits [HomeWatcherState.faulure()] when error',
      build: () => homeWatcherBloc,
      act: (bloc) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        bloc.add(const HomeWatcherEvent.started());
      },
      expect: () async => [
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatusHome.loading,
        ),
        predicate<HomeWatcherState>(
          (state) => state.loadingStatus == LoadingStatusHome.error,
        ),
      ],
    );
  });
}

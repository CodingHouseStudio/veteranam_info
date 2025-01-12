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
    late IFaqRepository mockFaqRepository;
    setUp(() {
      mockFaqRepository = MockIFaqRepository();
    });

    group(
        'emits [HomeWatcherState.loading(), HomeWatcherState.success()]'
        ' when load questionModel list', () {
      setUp(
        () => when(mockFaqRepository.getQuestions()).thenAnswer(
          (_) async => Right(KTestVariables.questionModelItems),
        ),
      );
      blocTest<HomeWatcherBloc, HomeWatcherState>(
        'Bloc Test',
        build: () => HomeWatcherBloc(
          faqRepository: mockFaqRepository,
        ),
        // act: (bloc) async {
        // },
        expect: () async => [
          predicate<HomeWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<HomeWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loaded,
          ),
        ],
      );
    });
    group('emits [HomeWatcherState.faulure()] when error', () {
      setUp(
        () => when(mockFaqRepository.getQuestions()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        ),
      );
      blocTest<HomeWatcherBloc, HomeWatcherState>(
        'Bloc Test',
        build: () => HomeWatcherBloc(
          faqRepository: mockFaqRepository,
        ),
        act: (bloc) async {
          bloc.add(const HomeWatcherEvent.started());
        },
        expect: () async => [
          predicate<HomeWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<HomeWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.error,
          ),
          predicate<HomeWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<HomeWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.error,
          ),
        ],
      );
    });
  });
}

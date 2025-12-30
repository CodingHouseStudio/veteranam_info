import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.mobFaq} ${KGroupText.bloc}', () {
    // late MobFaqWatcherBloc mobFaqWatcherBloc;
    late IFaqRepository mockFaqRepository;
    setUp(() {
      mockFaqRepository = MockIFaqRepository();
      when(mockFaqRepository.getQuestions()).thenAnswer(
        (_) async => Right(KTestVariables.questionModelItems),
      );
    });

    blocTest<MobFaqWatcherBloc, MobFaqWatcherState>(
      'emits [MobFaqWatcherState.loading(), MobFaqWatcherState.success()]'
      ' when load questionModel list',
      build: () => MobFaqWatcherBloc(
        faqRepository: mockFaqRepository,
      ),
      // act: (bloc) async {
      //   bloc.add(const MobFaqWatcherEvent.started());
      // },
      expect: () async => [
        predicate<MobFaqWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<MobFaqWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
    group('emits [MobFaqWatcherState.faulure()] when error', () {
      setUp(
        () => when(mockFaqRepository.getQuestions()).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        ),
      );
      blocTest<MobFaqWatcherBloc, MobFaqWatcherState>(
        'Bloc Test',
        build: () => MobFaqWatcherBloc(
          faqRepository: mockFaqRepository,
        ),
        // act: (bloc) async {
        //   bloc.add(const MobFaqWatcherEvent.started());
        // },
        expect: () async => [
          predicate<MobFaqWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<MobFaqWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.error,
          ),
        ],
      );
    });
  });
}

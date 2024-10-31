import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/mob_faq/bloc/mob_faq_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.mobFaq} ${KGroupText.bloc}', () {
    late MobFaqWatcherBloc mobFaqWatcherBloc;
    late IFaqRepository mockFaqRepository;
    setUp(() {
      mockFaqRepository = MockIFaqRepository();
      mobFaqWatcherBloc = MobFaqWatcherBloc(
        faqRepository: mockFaqRepository,
      );
    });

    blocTest<MobFaqWatcherBloc, MobFaqWatcherState>(
      'emits [MobFaqWatcherState.loading(), MobFaqWatcherState.success()]'
      ' when load questionModel list',
      build: () => mobFaqWatcherBloc,
      act: (bloc) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (_) async => Right(KTestText.questionModelItems),
        );
        bloc.add(const MobFaqWatcherEvent.started());
      },
      expect: () async => [
        predicate<MobFaqWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<MobFaqWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
    blocTest<MobFaqWatcherBloc, MobFaqWatcherState>(
      'emits [MobFaqWatcherState.faulure()] when error',
      build: () => mobFaqWatcherBloc,
      act: (bloc) async {
        when(mockFaqRepository.getQuestions()).thenAnswer(
          (_) async => Left(SomeFailure.serverError(error: null)),
        );
        bloc.add(const MobFaqWatcherEvent.started());
      },
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
}

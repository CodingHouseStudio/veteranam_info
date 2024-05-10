import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

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
        isA<HomeWatcherStateLoading>(),
        isA<HomeWatcherStateSuccess>(),
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
        isA<HomeWatcherStateLoading>(),
        isA<HomeWatcherStateFailure>(),
      ],
    );
  });
}

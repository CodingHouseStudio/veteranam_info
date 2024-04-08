// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group(KScreenBlocName.home, () {
    group(KGroupText.repository, () {
      late IHomeRepository mockHomeRepository;
      setUp(() {
        mockHomeRepository = MockIHomeRepository();
        when(mockHomeRepository.getQuestions()).thenAnswer(
          (_) => Stream.value(KTestText.questionModelItems),
        );
      });
      test('${KGroupText.successfulGet} questions', () async {
        expect(
          await mockHomeRepository.getQuestions().first,
          KTestText.questionModelItems,
        );
      });
    });

    group(KScreenBlocName.homeBloc, () {
      late HomeWatcherBloc homeWatcherBloc;
      late IHomeRepository mockHomeRepository;
      setUp(() {
        mockHomeRepository = MockIHomeRepository();
        homeWatcherBloc = HomeWatcherBloc(
          homeRepository: mockHomeRepository,
        );
        when(mockHomeRepository.getQuestions()).thenAnswer(
          (_) => Stream.value(KTestText.questionModelItems),
        );
      });

      blocTest<HomeWatcherBloc, HomeWatcherState>(
        'emits [HomeWatcherState.loading(), HomeWatcherState.success()] when load questionModel list',
        build: () => homeWatcherBloc,
        act: (bloc) async {
          bloc.add(const HomeWatcherEvent.started());
        },
        expect: () async => [
          isA<HomeWatcherStateLoading>(),
          isA<HomeWatcherStateSuccess>(),
        ],
      );
      blocTest<HomeWatcherBloc, HomeWatcherState>(
        'emits [HomeWatcherState.success()] when question update',
        build: () => homeWatcherBloc,
        act: (bloc) async {
          bloc.add(
            const HomeWatcherEvent.updated(
              questionModelItems: KTestText.questionModelItems,
            ),
          );
        },
        expect: () async => [
          const HomeWatcherState.success(
            questionModelItems: KTestText.questionModelItems,
          ),
        ],
      );
      blocTest<HomeWatcherBloc, HomeWatcherState>(
        'emits [HomeWatcherState.faulure()] when audit error',
        build: () => homeWatcherBloc,
        act: (bloc) async {
          bloc.add(const HomeWatcherEvent.failure());
        },
        expect: () async => [
          const HomeWatcherState.failure(),
        ],
      );
    });
  });
}

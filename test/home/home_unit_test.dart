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
    group(KGroupText.model, () {
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.questionModelItems.elementAt(0).id,
          'title': KTestText.questionModelItems.elementAt(0).title,
          'subtitle': KTestText.questionModelItems.elementAt(0).subtitle,
          'navigationLink':
              KTestText.questionModelItems.elementAt(0).navigationLink,
        };

        final questionModel = QuestionModel.fromJson(json);

        expect(questionModel.id, KTestText.questionModelItems.elementAt(0).id);
        expect(
          questionModel.title,
          KTestText.questionModelItems.elementAt(0).title,
        );
        expect(
          questionModel.subtitle,
          KTestText.questionModelItems.elementAt(0).subtitle,
        );
        expect(
          questionModel.navigationLink,
          KTestText.questionModelItems.elementAt(0).navigationLink,
        );
      });

      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.questionModelItems.elementAt(0).id,
          'title': KTestText.questionModelItems.elementAt(0).title,
          'subtitle': KTestText.questionModelItems.elementAt(0).subtitle,
        };

        final questionModel = QuestionModel.fromJson(json);

        expect(questionModel.id, KTestText.questionModelItems.elementAt(0).id);
        expect(
          questionModel.title,
          KTestText.questionModelItems.elementAt(0).title,
        );
        expect(
          questionModel.subtitle,
          KTestText.questionModelItems.elementAt(0).subtitle,
        );
        expect(questionModel.navigationLink, null);
      });

      test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.questionModelItems.elementAt(0).id,
          // title is missing
          'subtitle': KTestText.questionModelItems.elementAt(0).subtitle,
          'navigationLink':
              KTestText.questionModelItems.elementAt(0).navigationLink,
        };

        expect(
          () => QuestionModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.questionModelItems.elementAt(0).id,
          'title': List.generate(
            100,
            (_) => KTestText.questionModelItems
                .elementAt(0)
                .title
                .split(KTestText.questionModelItems.elementAt(0).title),
          ).join(),
          'subtitle': List.generate(
            100,
            (_) => KTestText.questionModelItems
                .elementAt(0)
                .subtitle
                .split(KTestText.questionModelItems.elementAt(0).subtitle),
          ).join(),
          'navigationLink':
              KTestText.questionModelItems.elementAt(0).navigationLink,
        };

        final questionModel = QuestionModel.fromJson(json);

        expect(questionModel.id, KTestText.questionModelItems.elementAt(0).id);
        expect(
          questionModel.title.length,
          KMinMaxSize.questionsTitleMaxLength,
        );
        expect(
          questionModel.subtitle.length,
          KMinMaxSize.questionsSubtitleMaxLength,
        );
        expect(questionModel.navigationLink, null);
      });
    });
    group(KGroupText.repository, () {
      late IHomeRepository mockHomeRepository;
      setUp(() {
        mockHomeRepository = MockIHomeRepository();
        when(mockHomeRepository.getQuestions()).thenAnswer(
          (_) => KTestText.questionModelItems,
        );
      });
      test('${KGroupText.successfulGet} questions', () async {
        expect(
          mockHomeRepository.getQuestions(),
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
      });

      blocTest<HomeWatcherBloc, HomeWatcherState>(
        'emits [HomeWatcherState.loading(), HomeWatcherState.success()]'
        ' when load questionModel list',
        build: () => homeWatcherBloc,
        act: (bloc) async {
          when(mockHomeRepository.getQuestions()).thenAnswer(
            (_) => KTestText.questionModelItems,
          );
          bloc.add(const HomeWatcherEvent.started());
        },
        expect: () async => [
          isA<HomeWatcherStateLoading>(),
          isA<HomeWatcherStateSuccess>(),
        ],
      );
      blocTest<HomeWatcherBloc, HomeWatcherState>(
        'emits [HomeWatcherState.faulure()] when audit error',
        build: () => homeWatcherBloc,
        act: (bloc) async {
          when(mockHomeRepository.getQuestions()).thenThrow(Exception());
          bloc.add(const HomeWatcherEvent.started());
        },
        expect: () async => [
          isA<HomeWatcherStateLoading>(),
          isA<HomeWatcherStateFailure>(),
        ],
      );
    });
  });
}

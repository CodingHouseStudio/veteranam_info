import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.investors} ', () {
    group('${KGroupText.model} ', () {
      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.fundItems.elementAt(0).id,
          'title': KTestText.fundItems.elementAt(0).title,
          'subtitle': KTestText.fundItems.elementAt(0).subtitle,
          'link': KTestText.fundItems.elementAt(0).link,
          'image': KTestText.fundItems.elementAt(0).image,
        };

        final fundModel = FundModel.fromJson(json);

        expect(fundModel.id, KTestText.fundItems.elementAt(0).id);
        expect(
          fundModel.title,
          KTestText.fundItems.elementAt(0).title,
        );
        expect(
          fundModel.subtitle,
          KTestText.fundItems.elementAt(0).subtitle,
        );
        expect(
          fundModel.link,
          KTestText.fundItems.elementAt(0).link,
        );
        expect(
          fundModel.image,
          KTestText.fundItems.elementAt(0).image,
        );
      });

      test('${KGroupText.shouldBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.fundItems.elementAt(0).id,
          'title': KTestText.fundItems.elementAt(0).title,
          'subtitle': KTestText.fundItems.elementAt(0).subtitle,
          'link': KTestText.fundItems.elementAt(0).link,
        };

        final fundModel = FundModel.fromJson(json);

        expect(fundModel.id, KTestText.fundItems.elementAt(0).id);
        expect(
          fundModel.title,
          KTestText.fundItems.elementAt(0).title,
        );
        expect(
          fundModel.subtitle,
          KTestText.fundItems.elementAt(0).subtitle,
        );
        expect(
          fundModel.link,
          KTestText.fundItems.elementAt(0).link,
        );
        expect(
          fundModel.image,
          null,
        );
      });

      test('${KGroupText.shouldNotBe} ${KGroupText.modelJson}', () {
        final json = {
          'id': KTestText.fundItems.elementAt(0).id,
          // title is missing
          'subtitle': KTestText.fundItems.elementAt(0).subtitle,
          'link': KTestText.fundItems.elementAt(0).link,
          'image': KTestText.fundItems.elementAt(0).image,
        };

        expect(
          () => FundModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.repository} ', () {
      late IInvestorsRepository mockInvestorsRepository;
      group('${KGroupText.successfulGet} ', () {
        setUp(() {
          mockInvestorsRepository = MockIInvestorsRepository();
          when(mockInvestorsRepository.getFunds()).thenAnswer(
            (_) async => const Right(KTestText.fundItems),
          );
        });
        test('questions', () async {
          expect(
            await mockInvestorsRepository.getFunds(),
            isA<Right<SomeFailure, List<FundModel>>>()
                .having((e) => e.value, 'value', KTestText.fundItems),
          );
        });
      });
      group('${KGroupText.failureGet} ', () {
        setUp(() {
          mockInvestorsRepository = MockIInvestorsRepository();
          when(mockInvestorsRepository.getFunds()).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
        });
        test('questions', () async {
          expect(
            await mockInvestorsRepository.getFunds(),
            isA<Left<SomeFailure, List<FundModel>>>().having(
              (e) => e.value,
              'value',
              equals(const SomeFailure.serverError()),
            ),
          );
        });
      });
    });

    group('${KScreenBlocName.investors} ', () {
      late InvestorsWatcherBloc investorsWatcherBloc;
      late IInvestorsRepository mockInvestorsRepository;
      setUp(() {
        mockInvestorsRepository = MockIInvestorsRepository();
        investorsWatcherBloc = InvestorsWatcherBloc(
          investorsRepository: mockInvestorsRepository,
        );
      });

      blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
        'emits [HomeWatcherState.loading(), HomeWatcherState.success()]'
        ' when load questionModel list',
        build: () => investorsWatcherBloc,
        act: (bloc) async {
          when(mockInvestorsRepository.getFunds()).thenAnswer(
            (_) async => const Right(KTestText.fundItems),
          );
          bloc.add(const InvestorsWatcherEvent.started());
        },
        expect: () async => [
          isA<InvestorsWatcherStateLoading>(),
          isA<InvestorsWatcherStateSuccess>(),
        ],
      );
      blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
        'emits [HomeWatcherState.faulure()] when error',
        build: () => investorsWatcherBloc,
        act: (bloc) async {
          when(mockInvestorsRepository.getFunds()).thenAnswer(
            (_) async => const Left(SomeFailure.serverError()),
          );
          bloc.add(const InvestorsWatcherEvent.started());
        },
        expect: () async => [
          isA<InvestorsWatcherStateLoading>(),
          isA<InvestorsWatcherStateFailure>(),
        ],
      );
    });
  });
}

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
  group('${KScreenBlocName.investors} ${KGroupText.bloc}', () {
    late InvestorsWatcherBloc investorsWatcherBloc;
    late IInvestorsRepository mockInvestorsRepository;
    setUp(() {
      mockInvestorsRepository = MockIInvestorsRepository();
      investorsWatcherBloc = InvestorsWatcherBloc(
        investorsRepository: mockInvestorsRepository,
      );
      when(mockInvestorsRepository.getFunds()).thenAnswer(
        (_) async => Right(KTestText.fundItems),
      );
    });

    blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
      'emits [HomeWatcherState.loading(), HomeWatcherState.success()]'
      ' when load questionModel list',
      build: () => investorsWatcherBloc,
      act: (bloc) async {
        bloc.add(const InvestorsWatcherEvent.started());
      },
      expect: () async => [
        predicate<InvestorsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InvestorsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
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
        predicate<InvestorsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InvestorsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.error,
        ),
      ],
    );
    blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
      'emits [InvestorsWatcherState()]'
      ' when load informationModel list and loadNextItems it',
      build: () => investorsWatcherBloc,
      act: (bloc) async {
        bloc.add(const InvestorsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InvestorsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InvestorsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const InvestorsWatcherEvent.loadeNextItems(),
        );
      },
      expect: () => [
        predicate<InvestorsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InvestorsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingFundItems.length == KDimensions.investorsLoadItems &&
              state.itemsLoaded == KDimensions.investorsLoadItems,
        ),
        predicate<InvestorsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.loadingFundItems.length ==
                  KDimensions.investorsLoadItems * 2 &&
              state.itemsLoaded == KDimensions.investorsLoadItems * 2,
        ),
      ],
    );
  });
}

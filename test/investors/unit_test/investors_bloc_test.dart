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
    });

    blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
      'emits [HomeWatcherState.loading(), HomeWatcherState.success()]'
      ' when load questionModel list',
      build: () => investorsWatcherBloc,
      act: (bloc) async {
        when(mockInvestorsRepository.getFunds()).thenAnswer(
          (_) async => Right(KTestText.fundItems),
        );
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
  });
}

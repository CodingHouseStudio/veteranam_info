import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.investors} ${KGroupText.bloc}', () {
    late InvestorsWatcherBloc investorsWatcherBloc;
    late IInvestorsRepository mockInvestorsRepository;
    // late IAppAuthenticationRepository mockAppAuthenticationRepository;
    // late IReportRepository mockReportRepository;
    setUp(() {
      mockInvestorsRepository = MockIInvestorsRepository();
      // mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      // mockReportRepository = MockIReportRepository();
      when(
        mockInvestorsRepository.getFunds(
            // reportIdItems: KTestText.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (_) async => Right(KTestVariables.fundItems),
      );
      // when(mockAppAuthenticationRepository.currentUser).thenAnswer(
      //   (invocation) => KTestText.user,
      // );
      // when(
      //   mockReportRepository.getCardReportById(
      //     cardEnum: CardEnum.funds,
      //     userId: KTestText.user.id,
      //   ),
      // ).thenAnswer(
      //   (invocation) async => Right(KTestText.reportItems),
      // );
      investorsWatcherBloc = InvestorsWatcherBloc(
        investorsRepository: mockInvestorsRepository,
        // reportRepository: mockReportRepository,
        // appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
      'emits [InvestorsWatcherState.loading(), InvestorsWatcherState.success()]'
      ' when load invesorModel list',
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
      'emits [InvestorsWatcherState.faulure()] when error',
      build: () => investorsWatcherBloc,
      act: (bloc) async {
        when(
          mockInvestorsRepository.getFunds(
              // reportIdItems: KTestText.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
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
    // blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
    //   'emits [InvestorsWatcherState()]'
    //   ' when load InvestorsModel list and loadNextItems it',
    //   build: () => investorsWatcherBloc,
    //   act: (bloc) async {
    //     bloc.add(const InvestorsWatcherEvent.started());
    //     await expectLater(
    //       bloc.stream,
    //       emitsInOrder([
    //         predicate<InvestorsWatcherState>(
    //           (state) => state.loadingStatus == LoadingStatus
    // .loading,
    //         ),
    //         predicate<InvestorsWatcherState>(
    //           (state) => state.loadingStatus == LoadingStatus
    // .loaded,
    //         ),
    //       ]),
    //       reason: 'Wait loading data',
    //     );
    //     bloc.add(
    //       const InvestorsWatcherEvent.loadNextItems(),
    //     );
    //     // when(
    //     //   mockReportRepository.getCardReportById(
    //     //     cardEnum: CardEnum.funds,
    //     //     userId: KTestText.user.id,
    //     //   ),
    //     // ).thenAnswer(
    //     //   (invocation) async => Right([KTestText.reportItems.first]),
    //     // );
    //     // bloc.add(
    //     //   const InvestorsWatcherEvent.getReport(),
    //     // );
    //   },
    //   expect: () => [
    //     predicate<InvestorsWatcherState>(
    //       (state) => state.loadingStatus == LoadingStatus.loading,
    //     ),
    //     predicate<InvestorsWatcherState>(
    //       (state) =>
    //           state.loadingStatus == LoadingStatus.loaded &&
    //           state.loadingMobFundItems.length ==
    //               KDimensions.investorsLoadItems &&
    //           state.itemsLoaded == KDimensions.investorsLoadItems,
    //       // &&
    //       // state.reportItems.isNotEmpty,
    //     ),
    //     predicate<InvestorsWatcherState>(
    //       (state) =>
    //           state.loadingStatus == LoadingStatus.loading &&
    //           state.loadingMobFundItems.length ==
    //               KDimensions.investorsLoadItems &&
    //           state.itemsLoaded == KDimensions.investorsLoadItems,
    //     ),
    //     predicate<InvestorsWatcherState>(
    //       (state) =>
    //           state.loadingStatus == LoadingStatus.loaded &&
    //           state.loadingMobFundItems.length ==
    //               KDimensions.investorsLoadItems * 2 &&
    //           state.itemsLoaded == KDimensions.investorsLoadItems * 2,
    //       //  &&
    //       // state.reportItems.length != 1,
    //     ),
    //     // predicate<InvestorsWatcherState>(
    //     //   (state) =>
    //     //       state.loadingStatus == LoadingStatus.loaded &&
    //     //       state.loadingFundItems.length ==
    //     //           KDimensions.investorsLoadItems * 2 &&
    //     //       state.itemsLoaded == KDimensions.investorsLoadItems * 2 &&
    //     //       state.reportItems.length == 1,
    //     // ),
    //   ],
    // );
    // blocTest<InvestorsWatcherBloc, InvestorsWatcherState>(
    //   'emits [InvestorsWatcherState()]'
    //   ' when get report failure and load nex with listLoadedFull',
    //   build: () => investorsWatcherBloc,
    //   act: (bloc) async {
    //     // when(
    //     //   mockReportRepository.getCardReportById(
    //     //     cardEnum: CardEnum.funds,
    //     //     userId: KTestText.user.id,
    //     //   ),
    //     // ).thenAnswer(
    //     //   (invocation) async => Left(
    //     //     SomeFailure.serverError(
    //     //       error: null,
    //     //     ),
    //     //   ),
    //     // );
    //     when(
    //       mockInvestorsRepository.getFunds(),
    //     ).thenAnswer(
    //       (_) async => Right([KTestText.fundItems.first]),
    //     );
    //     bloc.add(const InvestorsWatcherEvent.started());
    //     await expectLater(
    //       bloc.stream,
    //       emitsInOrder([
    //         predicate<InvestorsWatcherState>(
    //           (state) => state.loadingStatus == LoadingStatus
    // .loading,
    //         ),
    //         predicate<InvestorsWatcherState>(
    //           (state) => state.loadedFull,
    //         ),
    //       ]),
    //       reason: 'Wait loading data',
    //     );
    //     bloc.add(
    //       const InvestorsWatcherEvent.loadNextItems(),
    //     );
    //   },
    //   expect: () => [
    //     predicate<InvestorsWatcherState>(
    //       (state) => state.loadingStatus == LoadingStatus.loading,
    //     ),
    //     predicate<InvestorsWatcherState>(
    //       (state) => state.loadedFull,
    //     ),
    //   ],
    // );
  });
}

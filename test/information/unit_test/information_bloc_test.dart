import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/information/bloc/information_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.information} ${KGroupText.bloc}', () {
    late InformationWatcherBloc informationWatcherBloc;
    late IInformationRepository mockInformationRepository;
    // late IAppAuthenticationRepository mockAppAuthenticationRepository;
    // late IReportRepository mockReportRepository;

    setUp(() {
      mockInformationRepository = MockIInformationRepository();
      // mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      // mockReportRepository = MockIReportRepository();
      when(
        mockInformationRepository.getInformationItems(
            // reportIdItems: KTestVariables.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (_) => Stream.value(KTestVariables.informationModelItemsModify),
      );
      when(
        mockInformationRepository.updateLikeCount(
          informationModel: KTestVariables.informationModelItems.first,
          isLiked: true,
        ),
      ).thenAnswer(
        (_) async => const Right(true),
      );
      // when(mockAppAuthenticationRepository.currentUser).thenAnswer(
      //   (invocation) => KTestVariables.user,
      // );
      // when(
      //   mockReportRepository.getCardReportById(
      //     cardEnum: CardEnum.information,
      //     userId: KTestVariables.user.id,
      //   ),
      // ).thenAnswer(
      //   (invocation) async => Right(KTestVariables.reportItems),
      // );
      informationWatcherBloc = InformationWatcherBloc(
        informationRepository: mockInformationRepository,
        // reportRepository: mockReportRepository,
        // appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load informationModel list',
      build: () => informationWatcherBloc,
      act: (bloc) async => bloc.add(const InformationWatcherEvent.started()),
      expect: () async => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()] when error',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        when(
          mockInformationRepository.getInformationItems(
              // reportIdItems: KTestVariables.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (_) => Stream.error(KGroupText.failureGet),
        );
        bloc.add(const InformationWatcherEvent.started());
      },
      expect: () async => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.error &&
              state.failure != null,
        ),
      ],
    );

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()] when loading'
      ' informationModel list and filtering it',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        bloc.add(const InformationWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc.add(
          InformationWatcherEvent.filter(
            KTestVariables.informationModelItemsModify.first.categoryUA.first,
          ),
        );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filters.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              // state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.every(
                (element) => element.categoryUA.contains(
                  KTestVariables
                      .informationModelItemsModify.first.categoryUA.first,
                ),
              ) &&
              state.filters.isNotEmpty,
        ),
      ],
    );

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load informationModel list and loadNextItems it',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        bloc.add(const InformationWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const InformationWatcherEvent.loadNextItems(),
        );
        // when(
        //   mockReportRepository.getCardReportById(
        //     cardEnum: CardEnum.information,
        //     userId: KTestVariables.user.id,
        //   ),
        // ).thenAnswer(
        //   (invocation) async => Right([KTestVariables.reportItems.first]),
        // );
        // bloc.add(
        //   const InformationWatcherEvent.getReport(),
        // );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
          // &&
          // state.reportItems.isNotEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2,
          // &&
          // state.reportItems.length != 1,
        ),
        // predicate<InformationWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loaded &&
        //       state.filteredInformationModelItems.length ==
        //           KDimensions.loadItems * 2 &&
        //       state.itemsLoaded == KDimensions.loadItems * 2 &&
        //       state.reportItems.length == 1,
        // ),
      ],
    );
    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load informationModel list, loadNextItems and filter it',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        bloc.add(const InformationWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            const InformationWatcherEvent.loadNextItems(),
          )
          ..add(
            InformationWatcherEvent.filter(
              KTestVariables.informationModelItemsModify.first.categoryUA.first,
            ),
          );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filters.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filters.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filters.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              // state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.length == 1 &&
              state.filters.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
      ],
    );
    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load informationModel list, filter, loadNextItems,none filter'
      ' and loadNextItems it',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        bloc.add(const InformationWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            InformationWatcherEvent.filter(
              KTestVariables.informationModelItemsModify.first.categoryUA.first,
            ),
          )
          ..add(
            const InformationWatcherEvent.loadNextItems(),
          )
          ..add(
            InformationWatcherEvent.filter(
              KTestVariables.informationModelItemsModify.first.categoryUA.first,
            ),
          )
          ..add(
            const InformationWatcherEvent.loadNextItems(),
          );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filters.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              // state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.length == 1 &&
              state.filters.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredInformationModelItems.length == 1 &&
              state.filters.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              // state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.length == 1 &&
              state.filters.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems &&
              state.filters.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems &&
              state.filters.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filters.isEmpty,
        ),
      ],
    );

    // blocTest<InformationWatcherBloc, InformationWatcherState>(
    //   'emits [InformationWatcherState()] ',
    //   build: () => informationWatcherBloc,
    //   act: (bloc) async {
    //     bloc.add(const InformationWatcherEvent.started());
    //     await expectLater(
    //       bloc.stream,
    //       emitsInOrder([
    //         predicate<InformationWatcherState>(
    //           (state) => state.loadingStatus == LoadingStatus.loading,
    //         ),
    //         predicate<InformationWatcherState>(
    //           (state) => state.loadingStatus == LoadingStatus.loaded,
    //         ),
    //       ]),
    //       reason: 'Wait loading data',
    //     );
    //     bloc.add(
    //       InformationWatcherEvent.like(
    //         informationModel: KTestVariables.informationModelItems.first,
    //         isLiked: true,
    //       ),
    //     );
    //   },
    //   expect: () async => [
    //     predicate<InformationWatcherState>(
    //       (state) => state.loadingStatus == LoadingStatus.loading,
    //     ),
    //     predicate<InformationWatcherState>(
    //       (state) => state.loadingStatus == LoadingStatus.loaded,
    //     ),
    //     predicate<InformationWatcherState>(
    //       (state) => state.loadingStatus == LoadingStatus.loaded,
    //     ),
    //   ],
    // );

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()] when like',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        bloc.add(const InformationWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            InformationWatcherEvent.like(
              informationModel: KTestVariables.informationModelItems.first,
              isLiked: true,
            ),
          )
          ..add(
            InformationWatcherEvent.like(
              informationModel: KTestVariables.informationModelItems.first,
              isLiked: false,
            ),
          );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()] when change like',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        bloc.add(const InformationWatcherEvent.started());

        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          InformationWatcherEvent.changeLike(
            informationModel: KTestVariables.informationModelItems.first,
            isLiked: true,
          ),
        );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        // predicate<InformationWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loaded &&
        //       state.failure == null,
        // ),
      ],
    );

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()] when change like failure',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        when(
          mockInformationRepository.updateLikeCount(
            informationModel: KTestVariables.informationModelItems.first,
            isLiked: true,
          ),
        ).thenAnswer(
          (_) async => const Left(SomeFailure.serverError),
        );

        bloc.add(const InformationWatcherEvent.started());

        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          InformationWatcherEvent.changeLike(
            informationModel: KTestVariables.informationModelItems.first,
            isLiked: true,
          ),
        );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.error &&
              state.failure == SomeFailure.serverError,
        ),
      ],
    );
    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load nex with listLoadedFull',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        // when(
        //   mockReportRepository.getCardReportById(
        //     cardEnum: CardEnum.information,
        //     userId: KTestVariables.user.id,
        //   ),
        // ).thenAnswer(
        //   (invocation) async => Left(
        //     SomeFailure.serverError(
        //       error: null,
        //     ),
        //   ),
        // );
        when(
          mockInformationRepository.getInformationItems(),
        ).thenAnswer(
          (_) =>
              Stream.value([KTestVariables.informationModelItemsModify.first]),
        );
        bloc.add(const InformationWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<InformationWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            // predicate<InformationWatcherState>(
            //   (state) => state.loadingStatus == LoadingStatus.listLoadedFull,
            // ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const InformationWatcherEvent.loadNextItems(),
        );
      },
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              // state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filters.isEmpty,
        ),
      ],
    );
  });
}

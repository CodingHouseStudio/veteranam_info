import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.information} ${KGroupText.bloc}', () {
    late InformationWatcherBloc informationWatcherBloc;
    late IInformationRepository mockInformationRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IReportRepository mockReportRepository;

    setUp(() {
      mockInformationRepository = MockIInformationRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockReportRepository = MockIReportRepository();
      when(mockInformationRepository.getInformationItems()).thenAnswer(
        (_) => Stream.value(KTestText.informationModelItemsModify),
      );
      when(
        mockInformationRepository.updateLikeCount(
          informationModel: KTestText.informationModelItems.first,
          isLiked: true,
        ),
      ).thenAnswer(
        (_) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      when(
        mockReportRepository.getCardReportById(
          cardEnum: CardEnum.information,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.reportItems),
      );
      informationWatcherBloc = InformationWatcherBloc(
        informationRepository: mockInformationRepository,
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
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
        when(mockInformationRepository.getInformationItems()).thenAnswer(
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
          const InformationWatcherEvent.filter(
            0,
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
              state.filtersIndex.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.every(
                (element) => element.category.contains(
                  KTestText.informationModelItemsModify.first.category.first,
                ),
              ) &&
              state.filtersIndex.isNotEmpty,
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
        when(
          mockReportRepository.getCardReportById(
            cardEnum: CardEnum.information,
            userId: KTestText.user.id,
          ),
        ).thenAnswer(
          (invocation) async => Right([KTestText.reportItems.first]),
        );
        bloc.add(
          const InformationWatcherEvent.getReport(),
        );
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
              state.itemsLoaded == KDimensions.loadItems &&
              state.reportItems.isNotEmpty,
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
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.reportItems.length != 1,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.reportItems.length == 1,
        ),
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
            const InformationWatcherEvent.filter(
              0,
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
              state.filtersIndex.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filtersIndex.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersIndex.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.length == 1 &&
              state.filtersIndex.isNotEmpty &&
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
            const InformationWatcherEvent.filter(
              0,
            ),
          )
          ..add(
            const InformationWatcherEvent.loadNextItems(),
          )
          ..add(
            const InformationWatcherEvent.filter(
              0,
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
              state.filtersIndex.isEmpty,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.length == 1 &&
              state.filtersIndex.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredInformationModelItems.length == 1 &&
              state.filtersIndex.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredInformationModelItems.length == 1 &&
              state.filtersIndex.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersIndex.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersIndex.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<InformationWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredInformationModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersIndex.isEmpty,
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
    //         informationModel: KTestText.informationModelItems.first,
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
      'emits [InformationWatcherState()] ',
      build: () => informationWatcherBloc,
      act: (bloc) async => bloc
        ..add(const InformationWatcherEvent.started())
        ..add(
          InformationWatcherEvent.like(
            informationModel: KTestText.informationModelItems.first,
            isLiked: true,
          ),
        ),
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
      'emits [InformationWatcherState()] ',
      build: () => informationWatcherBloc,
      act: (bloc) async => bloc
        ..add(const InformationWatcherEvent.started())
        ..add(
          InformationWatcherEvent.changeLike(
            informationModel: KTestText.informationModelItems.first,
            isLiked: true,
          ),
        ),
      expect: () => [
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        predicate<InformationWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
  });
}

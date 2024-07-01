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
  group('${KScreenBlocName.information} ${KGroupText.bloc}', () {
    late InformationWatcherBloc informationWatcherBloc;
    late IInformationRepository mockInformationRepository;

    setUp(() {
      mockInformationRepository = MockIInformationRepository();
      informationWatcherBloc = InformationWatcherBloc(
        informationRepository: mockInformationRepository,
      );
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
              state.loadingStatus == LoadingStatus.loaded &&
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
              state.loadingStatus == LoadingStatus.loaded &&
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
              state.loadingStatus == LoadingStatus.loaded &&
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
              state.loadingStatus == LoadingStatus.loaded &&
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
    //   'emits [InformationWatcherState()] when error',
    //   build: () => informationWatcherBloc,
    //   act: (bloc) async => bloc
    //     ..add(const InformationWatcherEvent.started())
    //     ..add(
    //       InformationWatcherEvent.like(
    //         informatioIndex:
    //             int.parse(KTestText.informationModelItems.first.id),
    //         isLiked: true,
    //       ),
    //     ),

    //   expect: () async => [
    //     predicate<InformationWatcherState>(
    //       (state) => state.loadingStatus == LoadingStatus.loading,
    //     ),
    //     predicate<InformationWatcherState>(
    //       (state) => state.loadingStatus == LoadingStatus.error &&
    //           state.failure != null,
    //     ),
    //   ],
    // );
  });
}

import 'package:bloc_test/bloc_test.dart';
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
    });

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load informationModel list',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (_) => Stream.value(KTestText.informationModelItems),
        );
        bloc.add(const InformationWatcherEvent.started());
      },
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
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (_) => Stream.value(KTestText.informationModelItems),
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
          reason: 'Wait for loading data',
        );
        bloc.add(
          InformationWatcherEvent.filter(
            filter: KTestText.informationModelItems.first.category.first,
            isSelected: false,
          ),
        );
      },
      /*expect: () => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.isEmpty &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.isNotEmpty &&
                state.filteredInformationModelItems.first.category.contains(
                  KTestText.informationModelItems.first.category.first,
                ) &&
                state.filters == null,
          ),
        ],*/
    );

    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load informationModel list and loadNextItems it',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (_) => Stream.value(KTestText.informationModelItems),
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
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (_) => Stream.value(KTestText.informationModelItems),
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
        bloc
          ..add(
            const InformationWatcherEvent.loadNextItems(),
          )
          ..add(
            InformationWatcherEvent.filter(
              filter: KTestText.informationModelItems.first.category.first,
              isSelected: false,
            ),
          );
      },
      /*expect: () => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) !=
                    KTestText.informationModelItems.first &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.length == 2 &&
                state.itemsLoaded == 2 &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) ==
                    KTestText.informationModelItems.first &&
                state.filters != null &&
                state.itemsLoaded == 1,
          ),
        ],*/
    );
    blocTest<InformationWatcherBloc, InformationWatcherState>(
      'emits [InformationWatcherState()]'
      ' when load informationModel list, filter, loadNextItems,none filter'
      ' and loadNextItems it',
      build: () => informationWatcherBloc,
      act: (bloc) async {
        when(mockInformationRepository.getInformationItems()).thenAnswer(
          (_) => Stream.value(KTestText.informationModelItems),
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
        bloc
          ..add(
            InformationWatcherEvent.filter(
              filter: KTestText.informationModelItems.first.category.first,
              isSelected: false,
            ),
          )
          ..add(
            const InformationWatcherEvent.loadNextItems(),
          )
          ..add(
            InformationWatcherEvent.filter(
              filter: KTestText.informationModelItems.first.category.last,
              isSelected: false,
            ),
          )
          ..add(
            const InformationWatcherEvent.loadNextItems(),
          );
      },
      /* expect: () => [
          predicate<InformationWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) !=
                    KTestText.informationModelItems.first &&
                state.filters == null,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) ==
                    KTestText.informationModelItems.first &&
                state.filters != null &&
                state.itemsLoaded == 1,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filteredInformationModelItems.elementAt(0) ==
                    KTestText.informationModelItems.elementAt(0) &&
                state.filters == null &&
                state.itemsLoaded == 1,
          ),
          predicate<InformationWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                // Ensure the filtered item is the first one
                state.filteredInformationModelItems.length == 2 &&
                // Ensure itemsLoaded is updated and filters are null
                state.itemsLoaded == 2 &&
                state.filters == null,
          ),
        ],*/
    );
  });
}

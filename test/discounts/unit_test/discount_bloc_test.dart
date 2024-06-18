import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mockito/mockito.dart';

import '../../text_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} ${KGroupText.bloc}', () {
    late DiscountWatcherBloc discountWatcherBloc;
    late IDiscountRepository mockdiscountRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      discountWatcherBloc = DiscountWatcherBloc(
        discountRepository: mockdiscountRepository,
      );
      when(mockdiscountRepository.getDiscountItems()).thenAnswer(
        (_) => Stream.value(KTestText.discountModelItemsModify),
      );
    });

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountWatcherBloc,
      act: (bloc) async => bloc.add(const DiscountWatcherEvent.started()),
      expect: () async => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );
    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()] when error',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        when(mockdiscountRepository.getDiscountItems()).thenAnswer(
          (_) => Stream.error(KGroupText.failureGet),
        );
        bloc.add(const DiscountWatcherEvent.started());
      },
      expect: () async => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.error &&
              state.failure != null,
        ),
      ],
    );

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()] when loading'
      ' discountModel list and filtering it',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        bloc.add(const DiscountWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc.add(
          const DiscountWatcherEvent.filterCategory(
            0,
          ),
        );
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersCategoriesIndex == null,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.every(
                (element) => element.category.contains(
                  KTestText.discountModelItemsModify.first.category.first,
                ),
              ) &&
              state.filtersCategoriesIndex != null,
        ),
      ],
    );

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list and loadNextItems it',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        bloc.add(const DiscountWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const DiscountWatcherEvent.loadNextItems(),
        );
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2,
        ),
      ],
    );
    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list, loadNextItems and filter it',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        bloc.add(const DiscountWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          )
          ..add(
            const DiscountWatcherEvent.filterCategory(
              0,
            ),
          );
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersCategoriesIndex == null,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filtersCategoriesIndex == null,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersCategoriesIndex == null,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filtersCategoriesIndex != null &&
              state.itemsLoaded == 1,
        ),
      ],
    );
    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list, filter, loadNextItems,none filter'
      ' and loadNextItems it',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        bloc.add(const DiscountWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            const DiscountWatcherEvent.filterCategory(
              0,
            ),
          )
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          )
          ..add(
            const DiscountWatcherEvent.filterCategory(
              0,
            ),
          )
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          );
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersCategoriesIndex == null,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filtersCategoriesIndex != null &&
              state.itemsLoaded == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filtersCategoriesIndex != null &&
              state.itemsLoaded == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filtersCategoriesIndex != null &&
              state.itemsLoaded == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersCategoriesIndex != null &&
              state.filtersCategoriesIndex!.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersCategoriesIndex != null &&
              state.filtersCategoriesIndex!.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersCategoriesIndex != null &&
              state.filtersCategoriesIndex!.isEmpty,
        ),
      ],
    );
  });
}

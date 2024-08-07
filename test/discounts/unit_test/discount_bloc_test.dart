import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('${KScreenBlocName.discount} ${KGroupText.bloc}', () {
    late DiscountWatcherBloc discountWatcherBloc;
    late IDiscountRepository mockdiscountRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    late IReportRepository mockReportRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockReportRepository = MockIReportRepository();
      when(
        mockdiscountRepository.getDiscountItems(
          reportIdItems: KTestText.reportItems.getIdCard,
        ),
      ).thenAnswer(
        (_) => Stream.value(KTestText.discountModelItemsModify),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (invocation) => KTestText.user,
      );
      when(
        mockReportRepository.getCardReportById(
          cardEnum: CardEnum.discount,
          userId: KTestText.user.id,
        ),
      ).thenAnswer(
        (invocation) async => Right(KTestText.reportItems),
      );
      discountWatcherBloc = DiscountWatcherBloc(
        discountRepository: mockdiscountRepository,
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
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
        when(
          mockdiscountRepository.getDiscountItems(
            reportIdItems: KTestText.reportItems.getIdCard,
          ),
        ).thenAnswer(
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
      ' discountModel list and filtering category it',
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
        bloc
          ..add(
            const DiscountWatcherEvent.filterCategory(
              1,
            ),
          )
          ..add(
            const DiscountWatcherEvent.filterCategory(
              0,
            ),
          )
          ..add(
            const DiscountWatcherEvent.filterCategory(
              -1,
            ),
          )
          ..add(
            const DiscountWatcherEvent.filterCategory(
              1,
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
              state.filtersCategoriesIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.every(
                (element) => element.categoryEN.contains(
                  KTestText.discountModelItemsModify.first.categoryEN.first,
                ),
              ) &&
              state.filtersCategoriesIndex.length == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersCategoriesIndex.isNotEmpty &&
              state.filtersCategoriesIndex.length == 2,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersCategoriesIndex.isNotEmpty &&
              state.filtersCategoriesIndex.length == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filtersCategoriesIndex.isNotEmpty &&
              state.filtersCategoriesIndex.length == 1,
        ),
      ],
    );

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()] when loading'
      ' discountModel list and filtering location it',
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
        bloc
          ..add(const DiscountWatcherEvent.filterLocation(1))
          ..add(const DiscountWatcherEvent.filterLocation(1))
          ..add(const DiscountWatcherEvent.filterLocation(0))
          ..add(const DiscountWatcherEvent.filterLocation(2))
          ..add(const DiscountWatcherEvent.filterLocation(0))
          ..add(const DiscountWatcherEvent.filterLocation(2));
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersLocationIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filtersLocationIndex.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersLocationIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersLocationIndex.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.every(
                (element) => element.location!.contains(
                  KTestText.discountModelItemsModify.first.location!.first,
                ),
              ) &&
              state.filtersLocationIndex.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.every(
                (element) => element.location!.contains(
                  KTestText.discountModelItemsModify.first.location!.first,
                ),
              ) &&
              state.filtersLocationIndex.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersLocationIndex.isEmpty,
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
        when(
          mockReportRepository.getCardReportById(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
        ).thenAnswer(
          (invocation) async => Right([KTestText.reportItems.first]),
        );
        // bloc.add(const DiscountWatcherEvent.getReport());
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
          // &&
          // state.reportItems.isNotEmpty,
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
          // &&
          // state.reportItems.length != 1,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loaded &&
        //       state.filteredDiscountModelItems.length ==
        //           KDimensions.loadItems * 2 &&
        //       state.itemsLoaded == KDimensions.loadItems * 2 &&
        //       state.reportItems.length == 1,
        // ),
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
              1,
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
              state.filtersCategoriesIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filtersCategoriesIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersCategoriesIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.categoryDiscountModelItems.length == 1 &&
              state.filtersCategoriesIndex.isNotEmpty &&
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
              1,
            ),
          )
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          )
          ..add(
            const DiscountWatcherEvent.filterCategory(
              1,
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
              state.filtersCategoriesIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filtersCategoriesIndex.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.listLoadedFull &&
        //       state.filteredDiscountModelItems.length == 1 &&
        //       state.filtersCategoriesIndex.isNotEmpty &&
        //       state.itemsLoaded == 1,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersCategoriesIndex.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersCategoriesIndex.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersCategoriesIndex.isEmpty,
        ),
      ],
    );
    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when get report failure, load nex with listLoadedFull and filter'
      ' locations',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        when(
          mockReportRepository.getCardReportById(
            cardEnum: CardEnum.discount,
            userId: KTestText.user.id,
          ),
        ).thenAnswer(
          (invocation) async => const Left(SomeFailure.serverError()),
        );
        when(
          mockdiscountRepository.getDiscountItems(),
        ).thenAnswer(
          (_) => Stream.value([KTestText.discountModelItemsModify.first]),
        );
        bloc.add(const DiscountWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.listLoadedFull,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          )
          ..add(const DiscountWatcherEvent.filterLocations([0, 1]));
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filtersCategoriesIndex.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filtersCategoriesIndex.isEmpty &&
              state.filtersLocationIndex.length == 2,
        ),
      ],
    );
  });
}

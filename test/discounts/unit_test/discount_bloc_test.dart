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
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      mockReportRepository = MockIReportRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();

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
      when(
        mockFirebaseRemoteConfigProvider
            .getInt(DiscountWatcherBloc.loadingItemsKey),
      ).thenAnswer(
        (invocation) => KDimensions.loadItems,
      );
      discountWatcherBloc = DiscountWatcherBloc(
        discountRepository: mockdiscountRepository,
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
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
            DiscountWatcherEvent.filterCategory(
              KTestText.discountModelItemsModify.first.category.first,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterCategory(
              KTestText.discountModelItemsModify.last.category.first,
            ),
          )
          ..add(
            const DiscountWatcherEvent.filterCategory(
              CategoryEnum.all,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterCategory(
              KTestText.discountModelItemsModify.first.category.first,
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
              state.filtersCategories.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.every(
                (element) => element.categoryEN.contains(
                  KTestText.discountModelItemsModify.first.categoryEN.first,
                ),
              ) &&
              state.filtersCategories.length == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersCategories.isNotEmpty &&
              state.filtersCategories.length == 2,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filtersCategories.isNotEmpty &&
              state.filtersCategories.length == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filtersCategories.isNotEmpty &&
              state.filtersCategories.length == 1,
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
          ..add(const DiscountWatcherEvent.sorting(DiscountEnum.free))
          ..add(const DiscountWatcherEvent.sorting(DiscountEnum.free))
          ..add(
            const DiscountWatcherEvent.sorting(
              DiscountEnum.largestSmallest,
            ),
          )
          ..add(
            const DiscountWatcherEvent.filterLocation(
              SubLocation.all,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterLocation(
              KTestText.discountModelItemsModify.first.location!.first,
            ),
          )
          ..add(
            const DiscountWatcherEvent.filterLocation(
              SubLocation.all,
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
              state.sorting.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.sortingDiscountModelItems.length == 1 &&
              state.sorting.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.sorting.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.sorting.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.every(
                (element) => element.location!.contains(
                  KTestText.discountModelItemsModify.first.location!.first,
                ),
              ) &&
              state.filtersLocation.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.every(
                (element) => element.location!.contains(
                  KTestText.discountModelItemsModify.first.location!.first,
                ),
              ) &&
              state.filtersLocation.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersLocation.isNotEmpty,
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
            DiscountWatcherEvent.filterCategory(
              KTestText.discountModelItemsModify.first.category.first,
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
              state.filtersCategories.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filtersCategories.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersCategories.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.categoryDiscountModelItems.length == 1 &&
              state.filtersCategories.isNotEmpty &&
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
            DiscountWatcherEvent.filterCategory(
              KTestText.discountModelItemsModify.first.category.first,
            ),
          )
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          )
          ..add(
            DiscountWatcherEvent.filterCategory(
              KTestText.discountModelItemsModify.first.category.first,
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
              state.filtersCategories.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filtersCategories.isNotEmpty &&
              state.itemsLoaded == 1,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.listLoadedFull &&
        //       state.filteredDiscountModelItems.length == 1 &&
        //       state.filtersCategories.isNotEmpty &&
        //       state.itemsLoaded == 1,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersCategories.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loading &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filtersCategories.isEmpty &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              state.filtersCategories.isEmpty,
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
          ..add(
            DiscountWatcherEvent.setMobFilter(
              filterList: [
                KTestText.discountModelItemsModify.first.location!.first,
                KTestText.discountModelItemsModify.first.location!.last,
              ],
              sorting: [
                DiscountEnum.largestSmallest,
              ],
            ),
          );
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filtersCategories.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filtersCategories.isEmpty &&
              state.filtersLocation.length == 2,
        ),
      ],
    );
  });
}

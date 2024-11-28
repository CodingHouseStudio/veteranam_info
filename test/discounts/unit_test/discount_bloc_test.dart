import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} ${KGroupText.bloc}', () {
    late DiscountWatcherBloc discountWatcherBloc;
    late IDiscountRepository mockdiscountRepository;
    // late IAppAuthenticationRepository mockAppAuthenticationRepository;
    // late IReportRepository mockReportRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      // mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      // mockReportRepository = MockIReportRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();

      when(
        mockdiscountRepository.getDiscountItems(
            // reportIdItems: KTestText.reportItems.getIdCard,
            ),
      ).thenAnswer(
        (_) => Stream.value(KTestText.discountModelItemsModify),
      );
      // when(mockAppAuthenticationRepository.currentUser).thenAnswer(
      //   (invocation) => KTestText.user,
      // );
      // when(
      //   mockReportRepository.getCardReportById(
      //     cardEnum: CardEnum.discount,
      //     userId: KTestText.user.id,
      //   ),
      // ).thenAnswer(
      //   (invocation) async => Right(KTestText.reportItems),
      // );
      when(
        mockFirebaseRemoteConfigProvider
            .getInt(DiscountWatcherBloc.loadingItemsKey),
      ).thenAnswer(
        (invocation) => KDimensions.loadItems,
      );
      discountWatcherBloc = DiscountWatcherBloc(
        discountRepository: mockdiscountRepository,
        // reportRepository: mockReportRepository,
        // appAuthenticationRepository: mockAppAuthenticationRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      );
    });

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => discountWatcherBloc,
      act: (bloc) async =>
          bloc.add(const DiscountWatcherEvent.started(isEnglish: false)),
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
              // reportIdItems: KTestText.reportItems.getIdCard,
              ),
        ).thenAnswer(
          (_) => Stream.error(KGroupText.failureGet),
        );
        bloc.add(const DiscountWatcherEvent.started(isEnglish: false));
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
        bloc.add(const DiscountWatcherEvent.started(isEnglish: false));
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
              !state.filterCategory.haveSelectedValue,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.every(
                (element) => element.category.contains(
                  KTestText.discountModelItemsModify.first.category.first,
                ),
              ) &&
              state.filterCategory
                      .where(
                        (element) => element.isSelected,
                      )
                      .length ==
                  1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterCategory
                      .where(
                        (element) => element.isSelected,
                      )
                      .length ==
                  2,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterCategory
                  .where(
                    (element) => element.isSelected,
                  )
                  .isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filterCategory
                      .where(
                        (element) => element.isSelected,
                      )
                      .length ==
                  1,
        ),
      ],
    );

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()] when loading'
      ' discountModel list and filtering location it',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        bloc.add(const DiscountWatcherEvent.started(isEnglish: false));
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
              SubLocation.online,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterLocation(
              KTestText.discountModelItemsModify.first.location!.first,
            ),
          )
          ..add(
            const DiscountWatcherEvent.filterLocation(
              SubLocation.online,
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
              state.sorting
                  .where(
                    (element) => element.isSelected,
                  )
                  .isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.sortingDiscountModelItems.length == 1 &&
              state.sorting
                  .where(
                    (element) => element.isSelected,
                  )
                  .isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.sorting
                  .where(
                    (element) => element.isSelected,
                  )
                  .isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.sorting
                  .where(
                    (element) => element.isSelected,
                  )
                  .isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              // state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filterLocation.haveSelectedValue,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterLocation.haveSelectedValue,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              state.filterLocation.haveSelectedValue,
        ),
      ],
    );

    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list and loadNextItems it',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        bloc.add(const DiscountWatcherEvent.started(isEnglish: false));
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
        // when(
        //   mockReportRepository.getCardReportById(
        //     cardEnum: CardEnum.discount,
        //     userId: KTestText.user.id,
        //   ),
        // ).thenAnswer(
        //   (invocation) async => Right([KTestText.reportItems.first]),
        // );
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
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loading &&
        //       state.filteredDiscountModelItems.length ==
        //           KDimensions.loadItems &&
        //       state.itemsLoaded == KDimensions.loadItems,
        // ),
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
        bloc.add(const DiscountWatcherEvent.started(isEnglish: false));
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
              !state.filterCategory.haveSelectedValue,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loading &&
        //       !state.filterCategory.haveSelectedValue,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              !state.filterCategory.haveSelectedValue,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.categoryDiscountModelItems.length == 1 &&
              state.filterCategory.haveSelectedValue &&
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
        bloc.add(const DiscountWatcherEvent.started(isEnglish: false));
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
              !state.filterCategory.haveSelectedValue,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filteredDiscountModelItems.length == 1 &&
              state.filterCategory.haveSelectedValue &&
              state.itemsLoaded == 1,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.listLoadedFull &&
        //       state.filteredDiscountModelItems.length == 1 &&
        //       state.filterCategory.haveSelectedValue &&
        //       state.itemsLoaded == 1,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems &&
              !state.filterCategory.haveSelectedValue &&
              state.itemsLoaded == KDimensions.loadItems,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loading &&
        //       state.filteredDiscountModelItems.length ==
        //           KDimensions.loadItems &&
        //       !state.filterCategory.haveSelectedValue &&
        //       state.itemsLoaded == KDimensions.loadItems,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filteredDiscountModelItems.length ==
                  KDimensions.loadItems * 2 &&
              state.itemsLoaded == KDimensions.loadItems * 2 &&
              !state.filterCategory.haveSelectedValue,
        ),
      ],
    );
    blocTest<DiscountWatcherBloc, DiscountWatcherState>(
      'emits [discountWatcherState()]'
      ' when get report failure, load nex with listLoadedFull and filter'
      ' locations',
      build: () => discountWatcherBloc,
      act: (bloc) async {
        // when(
        //   mockReportRepository.getCardReportById(
        //     cardEnum: CardEnum.discount,
        //     userId: KTestText.user.id,
        //   ),
        // ).thenAnswer(
        //   (invocation) async => Left(
        //     SomeFailure.serverError(
        //       error: null,
        //     ),
        //   ),
        // );
        when(
          mockdiscountRepository.getDiscountItems(),
        ).thenAnswer(
          (_) => Stream.value([KTestText.discountModelItemsModify.first]),
        );
        bloc.add(const DiscountWatcherEvent.started(isEnglish: false));
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
                ...KTestText.discountModelItems.last.location!.map(
                  FilterItem.new,
                ),
                FilterItem(KAppText.allUkrainOnline),
              ],
              sorting: [
                FilterItem<DiscountEnum>(DiscountEnum.largestSmallest),
              ],
              choosenLocationList: [],
              choosenSortingnList: [],
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
              !state.filterCategory.haveSelectedValue,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.listLoadedFull &&
              state.filterLocation.length == 2,
        ),
      ],
    );
  });
}

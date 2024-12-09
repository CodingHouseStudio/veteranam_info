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
    late UserRepository mockUserRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      // mockAppAuthenticationRepository = MockIAppAuthenticationRepository();
      // mockReportRepository = MockIReportRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockUserRepository = MockUserRepository();

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
        userRepository: mockUserRepository,
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
              // reportIdItems: KTestText.reportItems.getIdCard,
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
              category:
                  KTestText.discountModelItemsModify.first.category.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterCategory(
              category:
                  KTestText.discountModelItemsModify.last.category.first.uk,
              isDesk: true,
            ),
          )
          // ..add(
          //   const DiscountWatcherEvent.filterCategory(
          //    category: CategoryEnum.all,
          //   ),
          // )
          ..add(
            DiscountWatcherEvent.filterCategory(
              category:
                  KTestText.discountModelItemsModify.first.category.first.uk,
              isDesk: true,
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
              !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              state.filterDiscountModelList.every(
                (element) => element.category.contains(
                  KTestText.discountModelItemsModify.first.category.first,
                ),
              ) &&
              state.discountFilterRepository.activeCategoryMap.length == 1,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.discountFilterRepository.activeCategoryMap.length == 2,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.discountFilterRepository.activeCategoryMap.isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              state.discountFilterRepository.activeCategoryMap.length == 1,
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
          ..add(
            const DiscountWatcherEvent.sorting(DiscountEnum.largestSmallest),
          )
          ..add(
            const DiscountWatcherEvent.sorting(DiscountEnum.largestSmallest),
          )
          ..add(
            const DiscountWatcherEvent.sorting(
              DiscountEnum.largestSmallest,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterLocation(
              location:
                  KTestText.discountModelItemsModify.last.location!.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterLocation(
              location:
                  KTestText.discountModelItemsModify.first.location!.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountWatcherEvent.filterLocation(
              location:
                  KTestText.discountModelItemsModify.last.location!.first.uk,
              isDesk: true,
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
              state.sortingBy == DiscountEnum.byDate,
          // .where(
          //   (element) => element.isSelected,
          // )
          // .isEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              // state.sortingDiscountModelItems.length == 1 &&
              state.sortingBy == DiscountEnum.largestSmallest,
          // .where(
          //   (element) => element.isSelected,
          // )
          // .isNotEmpty,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loaded &&
        //       state.filterDiscountModelList.length == KDimensions.loadItems
        // &&
        //       state
        //           .sorting
        //           // .where(
        //           //   (element) => element.isSelected,
        //           // )
        //           .isEmpty,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length == KDimensions.loadItems &&
              state.sortingBy == DiscountEnum.largestSmallest,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              // state.isListLoadedFull &&
              state.discountFilterRepository.activeLocationMap.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.discountFilterRepository.activeLocationMap.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length == KDimensions.loadItems &&
              state.discountFilterRepository.activeLocationMap.isNotEmpty,
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
              state.filterDiscountModelList.length == KDimensions.loadItems,
          // &&
          // state.reportItems.isNotEmpty,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loading &&
        //       state.filterDiscountModelList.length ==
        //           KDimensions.loadItems &&
        //       state.itemsLoaded == KDimensions.loadItems,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length == KDimensions.loadItems * 2,
          // &&
          // state.reportItems.length != 1,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loaded &&
        //       state.filterDiscountModelList.length ==
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
              category:
                  KTestText.discountModelItemsModify.first.category.first.uk,
              isDesk: true,
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
              !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loading &&
        //       !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length ==
                  KDimensions.loadItems * 2 &&
              !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              // state.categoryDiscountModelItems.length == 1 &&
              state.discountFilterRepository.activeCategoryMap.isNotEmpty,
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
              category:
                  KTestText.discountModelItemsModify.first.category.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          )
          ..add(
            DiscountWatcherEvent.filterCategory(
              category:
                  KTestText.discountModelItemsModify.first.category.first.uk,
              isDesk: true,
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
              !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              state.filterDiscountModelList.length == 1 &&
              state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.isListLoadedFull &&
        //       state.filterDiscountModelList.length == 1 &&
        //       state.discountFilterRepository.activeCategoryMap.isNotEmpty &&
        //       state.itemsLoaded == 1,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length == KDimensions.loadItems &&
              !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
        // predicate<DiscountWatcherState>(
        //   (state) =>
        //       state.loadingStatus == LoadingStatus.loading &&
        //       state.filterDiscountModelList.length ==
        //           KDimensions.loadItems &&
        //       !state.discountFilterRepository.activeCategoryMap.isNotEmpty &&
        //       state.itemsLoaded == KDimensions.loadItems,
        // ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length ==
                  KDimensions.loadItems * 2 &&
              !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
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
        bloc.add(const DiscountWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountWatcherState>(
              (state) => state.isListLoadedFull,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            const DiscountWatcherEvent.loadNextItems(),
          )
          ..add(
            const DiscountWatcherEvent.setMobFilter(),
          );
      },
      expect: () => [
        predicate<DiscountWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              !state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
        predicate<DiscountWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              state.discountFilterRepository.locationMap.length == 2,
        ),
      ],
    );
  });
}

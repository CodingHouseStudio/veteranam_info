// import 'package:bloc_test/bloc_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/components/discounts/bloc/watcher/discounts_watcher_bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';
import '../../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.discount} ${KGroupText.bloc}', () {
    // late DiscountsWatcherBloc discountWatcherBloc;
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
          showOnlyBusinessDiscounts: false,
          // reportIdItems: KTestVariables.reportItems.getIdCard,
        ),
      ).thenAnswer(
        (_) => Stream.value(KTestVariables.discountModelItemsModify),
      );
      // when(mockAppAuthenticationRepository.currentUser).thenAnswer(
      //   (invocation) => KTestVariables.user,
      // );
      // when(
      //   mockReportRepository.getCardReportById(
      //     cardEnum: CardEnum.discount,
      //     userId: KTestVariables.user.id,
      //   ),
      // ).thenAnswer(
      //   (invocation) async => Right(KTestVariables.reportItems),
      // );
      when(
        mockFirebaseRemoteConfigProvider
            .getInt(DiscountsWatcherBloc.loadingItemsKey),
      ).thenAnswer(
        (invocation) => KDimensions.loadItems,
      );
      when(
        mockUserRepository.currentUser,
      ).thenAnswer(
        (invocation) => KTestVariables.user,
      );
      when(
        mockUserRepository.currentUserSetting,
      ).thenAnswer(
        (invocation) => KTestVariables.userSetting,
      );
      // discountWatcherBloc = DiscountsWatcherBloc(
      //   discountRepository: mockdiscountRepository,
      //   // reportRepository: mockReportRepository,
      //   // appAuthenticationRepository: mockAppAuthenticationRepository,
      //   firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      // );
      if (GetIt.I.isRegistered<UserRepository>()) {
        GetIt.I.unregister<UserRepository>();
      }
      GetIt.I.registerSingleton<UserRepository>(mockUserRepository);
    });

    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        // reportRepository: mockReportRepository,
        // appAuthenticationRepository: mockAppAuthenticationRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      // act: (bloc) async => bloc.add(const DiscountsWatcherEvent.started()),
      expect: () async => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
      ],
    );

    group('emits [discountWatcherState()] when error', () {
      setUp(
        () => when(
          mockdiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
            // reportIdItems: KTestVariables.reportItems.getIdCard,
          ),
        ).thenAnswer(
          (_) => Stream.error(KGroupText.failureGet),
        ),
      );
      blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
        'Bloc Test',
        build: () => DiscountsWatcherBloc(
          discountRepository: mockdiscountRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        // act: (bloc) async {
        //  //// bloc.add(const DiscountsWatcherEvent.started());
        // },
        expect: () async => [
          predicate<DiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<DiscountsWatcherState>(
            (state) =>
                state.loadingStatus == LoadingStatus.error &&
                state.failure != null,
          ),
        ],
      );
    });
    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()] when loading'
      ' discountModel list and filtering category it',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
        // bloc.add(const DiscountsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.last.category.first.uk,
              isDesk: true,
            ),
          );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.filterStatus == FilterStatus.filtered &&
              state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
      ],
    );

    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()] when loading'
      ' discountModel list, filtering eligiblity and reset filter',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
        // bloc.add(const DiscountsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(
            DiscountsWatcherEvent.filterEligibilities(
              eligibility: EligibilityEnum.all.getTranslateModel.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterEligibilities(
              eligibility: EligibilityEnum.veterans.getTranslateModel.uk,
              isDesk: true,
            ),
          )
          ..add(const DiscountsWatcherEvent.filterReset());
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.filterStatus == FilterStatus.filtered &&
              !state.discountFilterRepository.hasActivityItem,
        ),
      ],
    );

    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()] when loading'
      ' discountModel list and filtering location it',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
        // bloc.add(const DiscountsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(
            const DiscountsWatcherEvent.sorting(DiscountEnum.largestSmallest),
          )
          ..add(
            const DiscountsWatcherEvent.sorting(DiscountEnum.largestSmallest),
          )
          ..add(
            const DiscountsWatcherEvent.sorting(DiscountEnum.byDate),
          )
          ..add(
            const DiscountsWatcherEvent.sorting(DiscountEnum.featured),
          );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.sortingBy == null,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.sortingBy == DiscountEnum.largestSmallest,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.sortingBy == DiscountEnum.byDate,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.sortingBy == DiscountEnum.featured,
        ),
      ],
    );

    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()] when loading'
      ' discountModel list and filtering location it',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
        // bloc.add(const DiscountsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait for loading data',
        );
        bloc
          ..add(
            DiscountsWatcherEvent.filterLocation(
              location: KTestVariables
                  .discountModelItemsModify.last.location!.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterLocation(
              location: KTestVariables
                  .discountModelItemsModify.first.location!.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterLocation(
              location: KTestVariables
                  .discountModelItemsModify.first.location!.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            const DiscountsWatcherEvent.searchLocation(
              KTestVariables.field,
            ),
          );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.sortingBy == null,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.filterStatus == FilterStatus.filtered &&
              state.filterDiscountModelList.length == KDimensions.loadItems &&
              state.discountFilterRepository.activeLocationMap.isNotEmpty &&
              state.discountFilterRepository.locationMap.isEmpty,
        ),
      ],
    );

    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list and loadNextItems it',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
        // bloc.add(const DiscountsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc.add(
          const DiscountsWatcherEvent.loadNextItems(),
        );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length == KDimensions.loadItems,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length == KDimensions.loadItems * 2,
        ),
      ],
    );
    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list, loadNextItems and filter it',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
        // bloc.add(const DiscountsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            const DiscountsWatcherEvent.loadNextItems(),
          )
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: true,
            ),
          );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterDiscountModelList.length == KDimensions.loadItems * 2,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.filterStatus == FilterStatus.filtered &&
              state.isListLoadedFull &&
              state.discountFilterRepository.activeCategoryMap.isNotEmpty,
        ),
      ],
    );
    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' when load discountModel list, filter, loadNextItems,none filter'
      ' and loadNextItems it',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
        // bloc.add(const DiscountsWatcherEvent.started());
        await expectLater(
          bloc.stream,
          emitsInOrder([
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loading,
            ),
            predicate<DiscountsWatcherState>(
              (state) => state.loadingStatus == LoadingStatus.loaded,
            ),
          ]),
          reason: 'Wait loading data',
        );
        bloc
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            const DiscountsWatcherEvent.loadNextItems(),
          )
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            const DiscountsWatcherEvent.loadNextItems(),
          );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loaded,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.filterStatus == FilterStatus.filtered &&
              state.isListLoadedFull &&
              state.filterDiscountModelList.length == 1,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.isListLoadedFull &&
              state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              !state.isListLoadedFull &&
              state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.filterStatus == FilterStatus.filtered &&
              state.filterDiscountModelList.length ==
                  KDimensions.loadItems * 2 &&
              state.discountFilterRepository.activeCategoryMap.isEmpty,
        ),
      ],
    );
    group(
        'emits [discountWatcherState()]'
        ' when load nex with listLoadedFull', () {
      setUp(
        () => when(
          mockdiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (_) => Stream.value([KTestVariables.discountModelItemsModify.first]),
        ),
      );
      blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
        'Bloc test',
        build: () => DiscountsWatcherBloc(
          discountRepository: mockdiscountRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        act: (bloc) async {
          // bloc.add(const DiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<DiscountsWatcherState>(
                (state) => state.isListLoadedFull,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc.add(
            const DiscountsWatcherEvent.loadNextItems(),
          );
        },
        expect: () => [
          predicate<DiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<DiscountsWatcherState>(
            (state) =>
                state.isListLoadedFull &&
                !state.discountFilterRepository.hasActivityItem,
          ),
        ],
      );
    });
    group(
        'emits [discountWatcherState()]'
        ' when load next and after it listLoadedFull', () {
      setUp(
        () => when(
          mockdiscountRepository.getDiscountItems(
            showOnlyBusinessDiscounts: false,
          ),
        ).thenAnswer(
          (_) => Stream.value(
            List.generate(
              KDimensions.loadItems * 2,
              (i) => KMockText.discountModel.copyWith(
                id: i.toString(),
                userName: i == 0 ? KTestVariables.user.name : null,
              ),
            ),
          ),
        ),
      );
      blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
        'Bloc test',
        build: () => DiscountsWatcherBloc(
          discountRepository: mockdiscountRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        act: (bloc) async {
          // bloc.add(const DiscountsWatcherEvent.started());
          await expectLater(
            bloc.stream,
            emitsInOrder([
              predicate<DiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loading,
              ),
              predicate<DiscountsWatcherState>(
                (state) => state.loadingStatus == LoadingStatus.loaded,
              ),
            ]),
            reason: 'Wait loading data',
          );
          bloc
            ..add(
              const DiscountsWatcherEvent.loadNextItems(),
            )
            ..add(
              const DiscountsWatcherEvent.loadNextItems(),
            );
        },
        expect: () => [
          predicate<DiscountsWatcherState>(
            (state) => state.loadingStatus == LoadingStatus.loading,
          ),
          predicate<DiscountsWatcherState>(
            (state) =>
                !state.isListLoadedFull &&
                !state.discountFilterRepository.hasActivityItem &&
                state.loadingStatus == LoadingStatus.loaded,
          ),
          predicate<DiscountsWatcherState>(
            (state) =>
                state.isListLoadedFull &&
                !state.discountFilterRepository.hasActivityItem &&
                state.filterDiscountModelList.length ==
                    KDimensions.loadItems * 2,
          ),
        ],
      );
    });
  });
}

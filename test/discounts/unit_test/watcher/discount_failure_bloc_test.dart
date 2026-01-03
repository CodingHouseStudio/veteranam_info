import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
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
    late IDiscountRepository mockdiscountRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late UserRepository mockUserRepository;
    late IDiscountFilterRepository mockDiscountFilterRepository;

    setUp(() {
      KTest.discountSortingTestValue = true;
      mockdiscountRepository = MockIDiscountRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockUserRepository = MockUserRepository();
      mockDiscountFilterRepository = MockIDiscountFilterRepository();

      when(
        mockDiscountFilterRepository.getFilterValuesFromDiscountItems(
          KTestVariables.discountModelItemsModify,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.getFilterList(
          KTestVariables.discountModelItemsModify,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.addRemoveCategory(
          valueUK:
              KTestVariables.discountModelItemsModify.first.category.first.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.addRemoveLocation(
          valueUK:
              KTestVariables.discountModelItemsModify.first.location!.first.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.addRemoveEligibility(
          valueUK: EligibilityEnum.combatants.getTranslateModel.uk,
          unmodifiedDiscountModelItems: KTestVariables.discountModelItemsModify,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.saveActiveFilter(),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.revertActiveFilter(
          KTestVariables.discountModelItemsModify,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.resetAll(
          KTestVariables.discountModelItemsModify,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );
      when(
        mockDiscountFilterRepository.locationSearch(
          KTestVariables.field,
        ),
      ).thenAnswer(
        (_) => const Left(SomeFailure.serverError),
      );

      when(
        mockdiscountRepository.getDiscountItems(
          showOnlyBusinessDiscounts: false,
        ),
      ).thenAnswer(
        (_) => Stream.value(KTestVariables.discountModelItemsModify),
      );
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
      DiscountsWatcherBloc.testDiscountFilterRepository =
          mockDiscountFilterRepository;

      if (GetIt.I.isRegistered<UserRepository>()) {
        GetIt.I.unregister<UserRepository>();
      }
      GetIt.I.registerSingleton<UserRepository>(mockUserRepository);
    });
    group(
        'add Category ${KGroupText.successful} and get list'
        ' ${KGroupText.failure}', () {
      setUp(
        () => when(
          mockDiscountFilterRepository.addRemoveCategory(
            valueUK:
                KTestVariables.discountModelItemsModify.first.category.first.uk,
            unmodifiedDiscountModelItems:
                KTestVariables.discountModelItemsModify,
          ),
        ).thenAnswer(
          (_) => const Right(true),
        ),
      );
      blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
        'emits [discountWatcherState()]'
        ' mobile filter category',
        build: () => DiscountsWatcherBloc(
          discountRepository: mockdiscountRepository,
          firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
        ),
        act: (bloc) async {
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
            (state) =>
                state.loadingStatus == LoadingStatus.loaded &&
                state.filterStatus == FilterStatus.error,
          ),
          predicate<DiscountsWatcherState>(
            (state) => state.filterStatus == FilterStatus.filtering,
          ),
          predicate<DiscountsWatcherState>(
            (state) => state.filterStatus == FilterStatus.error,
          ),
        ],
      );
    });
    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' mobile filter category',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
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
            DiscountsWatcherEvent.filterLocation(
              location: KTestVariables
                  .discountModelItemsModify.first.location!.first.uk,
              isDesk: true,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterEligibilities(
              eligibility: EligibilityEnum.combatants.getTranslateModel.uk,
              isDesk: true,
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
              state.filterStatus == FilterStatus.error,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.error,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.error,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.error,
        ),
      ],
    );
    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' mobile filter category',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
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
            const DiscountsWatcherEvent.filterReset(),
          )
          ..add(
            const DiscountsWatcherEvent.mobSaveFilter(),
          )
          ..add(
            const DiscountsWatcherEvent.mobRevertFilter(),
          )
          ..add(
            const DiscountsWatcherEvent.mobSetFilter(),
          );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterStatus == FilterStatus.error,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.error,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.error,
        ),
      ],
    );
    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' mobile filter category and search location',
      build: () => DiscountsWatcherBloc(
        discountRepository: mockdiscountRepository,
        firebaseRemoteConfigProvider: mockFirebaseRemoteConfigProvider,
      ),
      act: (bloc) async {
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
            const DiscountsWatcherEvent.searchLocation(KTestVariables.field),
          )
          ..add(
            const DiscountsWatcherEvent.sorting(DiscountEnum.byDate),
          );
      },
      expect: () => [
        predicate<DiscountsWatcherState>(
          (state) => state.loadingStatus == LoadingStatus.loading,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.loadingStatus == LoadingStatus.loaded &&
              state.filterStatus == FilterStatus.error,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) => state.filterStatus == FilterStatus.error,
        ),
      ],
    );
  });
}

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
    late IDiscountRepository mockdiscountRepository;
    late FirebaseRemoteConfigProvider mockFirebaseRemoteConfigProvider;
    late UserRepository mockUserRepository;

    setUp(() {
      mockdiscountRepository = MockIDiscountRepository();
      mockFirebaseRemoteConfigProvider = MockFirebaseRemoteConfigProvider();
      mockUserRepository = MockUserRepository();

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
      if (GetIt.I.isRegistered<UserRepository>()) {
        GetIt.I.unregister<UserRepository>();
      }
      GetIt.I.registerSingleton<UserRepository>(mockUserRepository);
    });
    blocTest<DiscountsWatcherBloc, DiscountsWatcherState>(
      'emits [discountWatcherState()]'
      ' mobile save and revert all filter',
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
            const DiscountsWatcherEvent.mobSaveFilter(),
          )
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: false,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterLocation(
              location: KTestVariables
                  .discountModelItemsModify.first.location!.first.uk,
              isDesk: false,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterEligibilities(
              eligibility: EligibilityEnum.combatants.getTranslateModel.uk,
              isDesk: false,
            ),
          )
          ..add(
            const DiscountsWatcherEvent.mobRevertFilter(),
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
      'emits [discountWatcherState()]'
      ' mobile save and set filter',
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
            const DiscountsWatcherEvent.mobSaveFilter(),
          )
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: false,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterLocation(
              location: KTestVariables
                  .discountModelItemsModify.first.location!.first.uk,
              isDesk: false,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterEligibilities(
              eligibility: EligibilityEnum.combatants.getTranslateModel.uk,
              isDesk: false,
            ),
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
          (state) => state.filterStatus == FilterStatus.filtered,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              state.discountFilterRepository.hasActivityItem &&
              state.isListLoadedFull,
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
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: false,
            ),
          )
          ..add(
            DiscountsWatcherEvent.filterCategory(
              category: KTestVariables
                  .discountModelItemsModify.first.category.first.uk,
              isDesk: false,
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
          (state) =>
              state.filterStatus == FilterStatus.filtered &&
              !state.isListLoadedFull,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              !state.isListLoadedFull &&
              state.filterStatus == FilterStatus.filtering,
        ),
        predicate<DiscountsWatcherState>(
          (state) =>
              !state.isListLoadedFull &&
              state.filterStatus == FilterStatus.filtered &&
              state.discountFilterRepository.activeCategoryMap.isEmpty,
        ),
      ],
    );
  });
}

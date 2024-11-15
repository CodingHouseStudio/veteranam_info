import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDown(GetIt.I.reset);
  group('Advanced Filter Mob ${KGroupText.cubit}', () {
    late AdvancedFilterMobCubit advancedFilterMobCubit;

    setUp(() {
      advancedFilterMobCubit = AdvancedFilterMobCubit()
        ..started(
          initialLocationFilter: [
            ...KTestText.discountModelItems.last.location!.map(
              FilterItem.new,
            ),
            FilterItem(KTestText.discountModelItems.first.subLocation),
          ],
          initialSorting: [
            SortingItem(DiscountEnum.largestSmallest),
          ],
          initChooseLocationList: [],
          initialChooseSorting: [],
        );
    });

    blocTest<AdvancedFilterMobCubit, AdvancedFilterMobState>(
      'emits [AdvancedFilterMobState()] when '
      'location filer and sorting',
      build: () => advancedFilterMobCubit,
      act: (bloc) => bloc
        ..sorting(DiscountEnum.free)
        ..sorting(DiscountEnum.free)
        ..sorting(
          DiscountEnum.largestSmallest,
        )
        ..changeFilterList(
          SubLocation.all,
        )
        ..changeFilterList(
          KTestText.discountModelItemsModify.first.location!.first,
        )
        ..changeFilterList(
          SubLocation.all,
        ),
      expect: () => [
        predicate<AdvancedFilterMobState>(
          (state) =>
              state.filtersLocation.isNotEmpty && state.sorting.length == 2,
        ),
        predicate<AdvancedFilterMobState>(
          (state) => state.sorting.length == 1,
        ),
        predicate<AdvancedFilterMobState>(
          (state) => state.sorting.isEmpty,
        ),
        predicate<AdvancedFilterMobState>(
          (state) => state.filtersLocation.length == 1,
        ),
        predicate<AdvancedFilterMobState>(
          (state) => state.filtersLocation.isEmpty,
        ),
        predicate<AdvancedFilterMobState>(
          (state) => state.filtersLocation.length == 1,
        ),
      ],
    );
  });
}

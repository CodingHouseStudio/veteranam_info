import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);
  group('Advanced Filter Mob ${KGroupText.cubit}', () {
    late AdvancedFilterMobCubit advancedFilterMobCubit;

    setUp(() {
      advancedFilterMobCubit = AdvancedFilterMobCubit()
        ..started(
          initialFilter: [
            ...KTestText.discountModelItems.last.location!,
            KTestText.discountModelItems.first.subLocation,
          ],
          initialSorting: [
            DiscountEnum.largestSmallest,
          ],
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
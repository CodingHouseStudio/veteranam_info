// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:veteranam/components/discounts/bloc/bloc.dart';
// import 'package:veteranam/shared/shared_dart.dart';

// import '../../test_dependency.dart';

void main() {
  // setUpAll(configureFailureDependenciesTest);

  // setupFirebaseAuthMocks();

  // setUpAll(setUpGlobal);

  // tearDownAll(GetIt.I.reset);
  // group('Advanced Filter Mob ${KGroupText.cubit}', () {
  //   late AdvancedFilterMobCubit advancedFilterMobCubit;

  //   setUp(() {
  //     advancedFilterMobCubit = AdvancedFilterMobCubit()
  //       ..started(
  //         initialLocationFilter: [
  //           ...KTestVariables.discountModelItems.last.location!.map(
  //             FilterItem.new,
  //           ),
  //           FilterItem(KAppText.allStoresOfChain),
  //         ],
  //         initialSorting: [
  //           FilterItem<DiscountEnum>(DiscountEnum.largestSmallest),
  //           FilterItem<DiscountEnum>(DiscountEnum.free),
  //         ],
  //         initChooseLocationList: [],
  //         initialChooseSorting: [],
  //       );
  //   });

  //   blocTest<AdvancedFilterMobCubit, AdvancedFilterMobState>(
  //     'emits [AdvancedFilterMobState()] when '
  //     'location filer and sorting',
  //     build: () => advancedFilterMobCubit,
  //     act: (bloc) => bloc
  //       ..sorting(DiscountEnum.free)
  //       ..sorting(DiscountEnum.free)
  //       ..sorting(
  //         DiscountEnum.largestSmallest,
  //       )
  //       ..changeLocationsList(
  //         SubLocation.all,
  //       )
  //       ..changeLocationsList(
  //         KTestVariables.discountModelItemsModify.first.location!.first,
  //       )
  //       ..changeLocationsList(
  //         SubLocation.all,
  //       ),
  //     expect: () => [
  //       predicate<AdvancedFilterMobState>(
  //         (state) =>
  //             state.sorting
  //                 .where(
  //                   (element) => element.isSelected,
  //                 )
  //                 .length ==
  //             1,
  //       ),
  //       predicate<AdvancedFilterMobState>(
  //         (state) => state.sorting
  //             .where(
  //               (element) => element.isSelected,
  //             )
  //             .isEmpty,
  //       ),
  //       predicate<AdvancedFilterMobState>(
  //         (state) =>
  //             state.sorting
  //                 .where(
  //                   (element) => element.isSelected,
  //                 )
  //                 .length ==
  //             1,
  //       ),
  //       predicate<AdvancedFilterMobState>(
  //         (state) =>
  //             state.filtersLocation
  //                 .where(
  //                   (element) => element.isSelected,
  //                 )
  //                 .length ==
  //             1,
  //       ),
  //       predicate<AdvancedFilterMobState>(
  //         (state) =>
  //             state.filtersLocation
  //                 .where(
  //                   (element) => element.isSelected,
  //                 )
  //                 .length ==
  //             2,
  //       ),
  //       predicate<AdvancedFilterMobState>(
  //         (state) =>
  //             state.filtersLocation
  //                 .where(
  //                   (element) => element.isSelected,
  //                 )
  //                 .length ==
  //             1,
  //       ),
  //     ],
  //   );
  // });
}

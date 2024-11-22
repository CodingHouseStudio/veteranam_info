part of 'discount_watcher_bloc.dart';

extension DiscountFailureExtension on SomeFailure {
  DiscountFailure _toDiscount() {
    return DiscountFailure.error;
  }
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> discountModelItems,
    required List<DiscountModel> filteredDiscountModelItems,
    required List<DiscountModel> categoryDiscountModelItems,
    required List<DiscountModel> locationDiscountModelItems,
    required List<DiscountModel> sortingDiscountModelItems,
    required List<DiscountModel> eligibilitiesDiscountModelItems,
    // required List<dynamic> chooseFilterItems,
    required List<FilterItem<String>> filterLocation,
    required List<FilterItem<String>> filterEligibilities,
    required List<FilterItem<String>> choosenLocationList,
    required List<FilterItem<String>> choosenCategoriesnList,
    required List<FilterItem<String>> choosenEligibilitiesList,
    required List<FilterItem<String>> filterCategory,
    required List<FilterItem<DiscountEnum>> sorting,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required DiscountFailure? failure,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}

// extension LocationGetter on List<DiscountModel> {
//   List<FilterItem> _getLocationItems(
//     List<DiscountModel>? listForFilter,
//   ) =>
//       <FilterItem>[
//         FilterItem(''),
//         FilterItem(''),
//         FilterItem(SubLocation.allStoresOfChain),
//         FilterItem(SubLocation.online),
//         ...overallItems(
//           getENFilter: (item) => item.location ?? [],
//           context: null,
//           numberGetList: listForFilter,
//         ),
//       ];
// }

extension SubLocationString on SubLocation {
  String get _getList {
    return KAppText.sulocationUA;
    // switch (this) {
    //   case SubLocation.all:
    //     return [
    //       SubLocation.allStoresOfChain,
    //       SubLocation.online,
    //     ];
    //   case SubLocation.allStoresOfChain:
    //   case SubLocation.online:
    //     return [this];
    // }
  }
}

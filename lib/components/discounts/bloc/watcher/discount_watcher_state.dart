part of 'discount_watcher_bloc.dart';

enum DiscountFailure {
  error,
  report,
}

enum DiscountEnum {
  largestSmallest,
  free,
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> discountModelItems,
    required List<DiscountModel> filteredDiscountModelItems,
    required List<DiscountModel> categoryDiscountModelItems,
    required List<DiscountModel> locationDiscountModelItems,
    required List<dynamic> filtersCategories,
    required List<dynamic> filtersLocation,
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
  List<SubLocation> get _getList {
    switch (this) {
      case SubLocation.all:
        return [
          SubLocation.allStoresOfChain,
          SubLocation.online,
        ];
      case SubLocation.allStoresOfChain:
      case SubLocation.online:
        return [this];
    }
  }
}

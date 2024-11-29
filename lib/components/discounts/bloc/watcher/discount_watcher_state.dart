part of 'discount_watcher_bloc.dart';

extension DiscountFailureExtension on SomeFailure {
  DiscountFailure _toDiscount() {
    return DiscountFailure.error;
  }
}

enum FilterStatus {
  initial,
  filtering,
  filtered,
  error,
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> unmodifiedDiscountModelItems,
    // required List<dynamic> chooseFilterItems,
    required FilterItemsModel filterItemsModel,
    required LoadingStatus loadingStatus,
    required FilterStatus filterStatus,
    required List<DiscountModel> filterDiscountModelList,
    required List<DiscountEnum> sorting,
    required bool isListLoadedFull,
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

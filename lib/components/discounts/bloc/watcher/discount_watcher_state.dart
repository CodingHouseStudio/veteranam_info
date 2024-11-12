part of 'discount_watcher_bloc.dart';

class SortingItem extends FilterItem {
  SortingItem(
    DiscountEnum value, {
    super.isSelected = false,
    super.number,
  })  : _value = value,
        super(null);
  final DiscountEnum _value;

  @override
  DiscountEnum get value => _value;

  @override
  SortingItem copyWith({
    dynamic value,
    dynamic valueEN,
    bool? isSelected,
    int? number,
  }) {
    return SortingItem(
      value is DiscountEnum ? value : _value,
      isSelected: isSelected ?? this.isSelected,
      number: number ?? this.number,
    );
  }
}

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
    // required List<dynamic> chooseFilterItems,
    required List<FilterItem> filterLocation,
    required List<FilterItem> choosenLocationList,
    required List<SortingItem> choosenSortingnList,
    required List<FilterItem> filterCategory,
    required List<SortingItem> sorting,
    required bool categoryListEmpty,
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
    return [SubLocation.all];
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

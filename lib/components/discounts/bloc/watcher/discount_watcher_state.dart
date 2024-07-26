part of 'discount_watcher_bloc.dart';

enum DiscountFailure {
  error,
  report,
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> discountModelItems,
    required List<DiscountModel> filteredDiscountModelItems,
    required List<DiscountModel> categoryDiscountModelItems,
    required List<int> filtersCategoriesIndex,
    required List<int> filtersLocationIndex,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required DiscountFailure? failure,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}

extension LocationGetter on List<DiscountModel> {
  List<FilterItem> get _getLocationItems => <FilterItem>[
        FilterItem(''),
        FilterItem(''),
        FilterItem(SubLocation.allStoresOfChain),
        FilterItem(SubLocation.online),
        ...overallItems(
          getFilter: (item) => item.location ?? [],
          context: null,
        ),
      ];
}

extension SubLocationString on SubLocation? {
  List<SubLocation> get _getList {
    switch (this) {
      case null:
        return [];
      case SubLocation.all:
        return [
          SubLocation.allStoresOfChain,
          SubLocation.online,
        ];
      case SubLocation.allStoresOfChain:
      case SubLocation.online:
        return [this!];
    }
  }
}

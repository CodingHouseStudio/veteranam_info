part of 'discount_watcher_bloc.dart';

enum DiscountFailure {
  error,
  report,
}

enum SortEnum {
  reverse,
  free,
  old,
  indefinitely,
  expired,
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> discountModelItems,
    required List<DiscountModel> filteredDiscountModelItems,
    required List<int> filtersCategoriesIndex,
    required List<int> filtersSubcategoriesIndex,
    required List<int> filtersLocationIndex,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required DiscountFailure? failure,
    required List<ReportModel> reportItems,
  }) = _Initial;
}

extension LocationGetter on List<DiscountModel> {
  List<dynamic> get _getLocationItems => <dynamic>[
        // '',
        // '',
        SubLocation.allStoresOfChain,
        SubLocation.online,
        ...overallItemBloc(
          getFilter: (item) => item.location ?? [],
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

part of 'discount_watcher_bloc.dart';

@freezed
class DiscountWatcherEvent with _$DiscountWatcherEvent {
  const factory DiscountWatcherEvent.started({required bool isEnglish}) =
      _Started;

  const factory DiscountWatcherEvent.updated({
    required List<DiscountModel> discountItemsModel,
    required bool isEnglish,
  }) = _Updated;

  const factory DiscountWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory DiscountWatcherEvent.filterCategory(
    dynamic value,
  ) = _FilterCategory;

  const factory DiscountWatcherEvent.filterLocation(
    dynamic value,
  ) = _FilterLocation;

  const factory DiscountWatcherEvent.setMobFilter({
    required List<FilterItem> filterList,
    required List<SortingItem> sorting,
    required List<FilterItem> choosenLocationList,
    required List<SortingItem> choosenSortingnList,
  }) = _SetMobFilter;

  const factory DiscountWatcherEvent.sorting(
    DiscountEnum value,
  ) = _Sorting;

  const factory DiscountWatcherEvent.filterReset() = _FilterReset;

  const factory DiscountWatcherEvent.failure({
    required Object? error,
    required StackTrace stack,
  }) = _Failure;

  // const factory DiscountWatcherEvent.getReport() = _GetReport;
}

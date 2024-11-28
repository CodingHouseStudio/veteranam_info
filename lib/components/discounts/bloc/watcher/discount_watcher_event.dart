part of 'discount_watcher_bloc.dart';

@freezed
class DiscountWatcherEvent with _$DiscountWatcherEvent {
  const factory DiscountWatcherEvent.started() = _Started;

  const factory DiscountWatcherEvent.updated(
    List<DiscountModel> discountItemsModel,
  ) = _Updated;

  const factory DiscountWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory DiscountWatcherEvent.filterCategory(
    String value,
  ) = _FilterCategory;

  const factory DiscountWatcherEvent.filterEligibilities(
    String value,
  ) = _FilterEligibilities;

  const factory DiscountWatcherEvent.filterLocation(
    String value,
  ) = _FilterLocation;

  const factory DiscountWatcherEvent.setMobFilter({
    required List<FilterItem> filterList,
    required List<FilterItem> categories,
    required List<FilterItem> choosenLocationList,
    required List<FilterItem> choosenCategoriesList,
    required List<FilterItem> choosenEligibilitiesList,
    required List<FilterItem> filterEligibilities,
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

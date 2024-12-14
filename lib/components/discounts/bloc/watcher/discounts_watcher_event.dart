part of 'discounts_watcher_bloc.dart';

@freezed
class DiscountsWatcherEvent with _$DiscountsWatcherEvent {
  const factory DiscountsWatcherEvent.started() = _Started;

  const factory DiscountsWatcherEvent.updated(
    List<DiscountModel> discountItemsModel,
  ) = _Updated;

  const factory DiscountsWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory DiscountsWatcherEvent.filterCategory({
    required String category,
    required bool isDesk,
  }) = _FilterCategory;

  const factory DiscountsWatcherEvent.filterEligibilities({
    required String eligibility,
    required bool isDesk,
  }) = _FilterEligibilities;

  const factory DiscountsWatcherEvent.filterLocation({
    required String location,
    required bool isDesk,
  }) = _FilterLocation;

  const factory DiscountsWatcherEvent.searchLocation(
    String serachText,
  ) = _SearchLocation;

  const factory DiscountsWatcherEvent.setMobFilter() = _SetMobFilter;

  const factory DiscountsWatcherEvent.sorting(
    DiscountEnum value,
  ) = _Sorting;

  const factory DiscountsWatcherEvent.filterReset() = _FilterReset;

  const factory DiscountsWatcherEvent.failure({
    required Object? error,
    required StackTrace stack,
  }) = _Failure;

  // const factory DiscountWatcherEvent.getReport() = _GetReport;
}

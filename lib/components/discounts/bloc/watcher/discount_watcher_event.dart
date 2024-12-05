part of 'discount_watcher_bloc.dart';

@freezed
class DiscountWatcherEvent with _$DiscountWatcherEvent {
  const factory DiscountWatcherEvent.started() = _Started;

  const factory DiscountWatcherEvent.updated(
    List<DiscountModel> discountItemsModel,
  ) = _Updated;

  const factory DiscountWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory DiscountWatcherEvent.filterCategory({
    required String category,
    required bool isDesk,
  }) = _FilterCategory;

  const factory DiscountWatcherEvent.filterEligibilities({
    required String eligibility,
    required bool isDesk,
  }) = _FilterEligibilities;

  const factory DiscountWatcherEvent.filterLocation({
    required String location,
    required bool isDesk,
  }) = _FilterLocation;

  const factory DiscountWatcherEvent.searchLocation(
    String serachText,
  ) = _SearchLocation;

  const factory DiscountWatcherEvent.setMobFilter() = _SetMobFilter;

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

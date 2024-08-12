part of 'discount_watcher_bloc.dart';

@freezed
class DiscountWatcherEvent with _$DiscountWatcherEvent {
  const factory DiscountWatcherEvent.started() = _Started;

  const factory DiscountWatcherEvent.updated(
    List<DiscountModel> discountItemsModel,
  ) = _Updated;

  const factory DiscountWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory DiscountWatcherEvent.filterCategory(
    dynamic value,
  ) = _FilterCategory;

  const factory DiscountWatcherEvent.filterLocation(
    dynamic value,
  ) = _FilterLocation;

  const factory DiscountWatcherEvent.filterLocations(
    List<dynamic> filterList,
  ) = _FilterLocations;

  const factory DiscountWatcherEvent.filterReset() = _FilterReset;

  const factory DiscountWatcherEvent.failure(dynamic failure) = _Failure;

  // const factory DiscountWatcherEvent.getReport() = _GetReport;
}

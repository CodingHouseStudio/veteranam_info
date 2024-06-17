part of 'discount_watcher_bloc.dart';

@freezed
class DiscountWatcherEvent with _$DiscountWatcherEvent {
  const factory DiscountWatcherEvent.started() = _Started;

  const factory DiscountWatcherEvent.updated(
    List<DiscountModel> discountItemsModel,
  ) = _Updated;

  const factory DiscountWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory DiscountWatcherEvent.filterCategory(
    int filterIndex,
  ) = _FilterCategory;

  const factory DiscountWatcherEvent.filterCity(
    int filterIndex,
  ) = _FilterCity;

  const factory DiscountWatcherEvent.filterReset() = _FilterReset;

  const factory DiscountWatcherEvent.failure(dynamic failure) = _Failure;
}

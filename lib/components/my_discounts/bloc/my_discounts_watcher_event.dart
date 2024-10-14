part of 'my_discounts_watcher_bloc.dart';

@freezed
class MyDiscountsWatcherEvent with _$MyDiscountsWatcherEvent {
  const factory MyDiscountsWatcherEvent.started() = _Started;
  const factory MyDiscountsWatcherEvent.loadNextItems() = _LoadNextItems;
  const factory MyDiscountsWatcherEvent.deleteDiscount(String discountId) =
      _DeleteDiscount;
  const factory MyDiscountsWatcherEvent.deactivate({
    required DiscountModel discountModel,
    required bool isDeactivate,
  }) = _Deactivate;
  const factory MyDiscountsWatcherEvent.changeDeactivate({
    required DiscountModel discountModel,
    required bool isDeactivate,
  }) = _ChangeDeactivate;
  const factory MyDiscountsWatcherEvent.updated(
    List<DiscountModel> discountItemsModel,
  ) = _Updated;
  const factory MyDiscountsWatcherEvent.failure({
    required Object? error,
    required StackTrace stack,
  }) = _Failure;
}

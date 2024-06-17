part of 'my_discounts_watcher_bloc.dart';

@freezed
class MyDiscountsWatcherEvent with _$MyDiscountsWatcherEvent {
  const factory MyDiscountsWatcherEvent.started() = _Started;
  const factory MyDiscountsWatcherEvent.deleteDiscount(String discountId) =
      _DeleteDiscount;
}

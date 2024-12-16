part of 'discount_watcher_bloc.dart';

@freezed
class DiscountWatcherEvent with _$DiscountWatcherEvent {
  const factory DiscountWatcherEvent.started({
    required DiscountModel? discount,
    required String? discountId,
  }) = _Started;
}

part of 'discount_watcher_bloc.dart';

@freezed
sealed class DiscountWatcherEvent with _$DiscountWatcherEvent {
  const factory DiscountWatcherEvent.started(
    String? discountId,
  ) = _Started;
}

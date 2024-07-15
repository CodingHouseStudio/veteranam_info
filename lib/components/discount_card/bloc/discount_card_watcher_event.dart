part of 'discount_card_watcher_bloc.dart';

@freezed
class DiscountCardWatcherEvent with _$DiscountCardWatcherEvent {
  const factory DiscountCardWatcherEvent.started(String? id) = _Started;
}

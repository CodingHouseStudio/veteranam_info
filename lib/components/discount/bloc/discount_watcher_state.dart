part of 'discount_watcher_bloc.dart';

enum DiscountFailure {
  error,
  linkWrong,
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required DiscountModel discountModel,
    required LoadingStatus loadingStatus,
    DiscountFailure? failure,
  }) = _Initial;
}
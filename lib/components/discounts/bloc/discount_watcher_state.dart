part of 'discount_watcher_bloc.dart';

enum DiscountFailure {
  error,
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> discountModelItems,
    required List<DiscountModel> filteredDiscountModelItems,
    required List<int>? filtersCategoriesIndex,
    required List<int>? filtersCitiesIndex,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required DiscountFailure? failure,
  }) = _Initial;
}

part of 'discount_watcher_bloc.dart';

enum DiscountFailure {
  error,
}

extension DiscountFailureExtension on SomeFailure {
  DiscountFailure toDiscount() {
    return DiscountFailure.error;
  }
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> discountModelItems,
    required List<DiscountModel> filteredDiscountModelItems,
    required List<String>? filters,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required DiscountFailure? failure,
  }) = _Initial;
}

extension DiscountModelExtensions on List<DiscountModel> {
  List<String> get overallTags {
    final allTags = <String>[];
    for (final item in this) {
      allTags.addAll(item.tags);
    }
    return allTags.toSet().toList();
  }
}

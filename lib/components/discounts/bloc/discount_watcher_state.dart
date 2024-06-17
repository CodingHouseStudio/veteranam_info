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

extension DiscountModelExtensions on List<DiscountModel> {
  List<String> get overallTagsBloc {
    final allTags = <String>[];
    for (final item in this) {
      allTags.addAll(
        item.category,
      );
    }
    return allTags.toSet().toList();
  }

  List<String> get overallCities {
    final allCities = <String>[];
    for (final item in this) {
      if (item.location != null) {
        allCities.addAll(
          item.location!,
        );
      }
    }
    return allCities.toSet().toList();
  }
}

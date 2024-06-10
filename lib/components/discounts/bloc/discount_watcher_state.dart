part of 'discount_watcher_bloc.dart';

enum DiscountFailure {
  error,
}

extension DiscountFailureValue on DiscountFailure {
  String value(BuildContext context) {
    switch (this) {
      case DiscountFailure.error:
        return context.l10n.error;
    }
  }
}

@freezed
class DiscountWatcherState with _$DiscountWatcherState {
  const factory DiscountWatcherState({
    required List<DiscountModel> discountModelItems,
    required List<DiscountModel> filteredDiscountModelItems,
    required List<int>? filtersIndex,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required DiscountFailure? failure,
  }) = _Initial;
}

extension DiscountModelExtensions on List<DiscountModel> {
  List<String> overallTags(BuildContext context) {
    final allTags = <String>[];
    for (final item in this) {
      allTags.addAll(
        context.read<AuthenticationBloc>().state.userSetting.locale ==
                Language.english
            ? item.category
            : item.categoryUA,
      );
    }
    return allTags.toSet().toList();
  }

  List<String> get overallTagsBloc {
    final allTags = <String>[];
    for (final item in this) {
      allTags.addAll(
        item.category,
      );
    }
    return allTags.toSet().toList();
  }
}

part of 'information_watcher_bloc.dart';

enum InformationFailure {
  error,
}

extension InformationFailureValue on InformationFailure {
  String value(BuildContext context) {
    switch (this) {
      case InformationFailure.error:
        return context.l10n.error;
    }
  }
}

@freezed
class InformationWatcherState with _$InformationWatcherState {
  const factory InformationWatcherState({
    required List<InformationModel> informationModelItems,
    required List<InformationModel> filteredInformationModelItems,
    required List<int>? filtersIndex,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required InformationFailure? failure,
  }) = _Initial;
}

extension InformationModelExtensions on List<InformationModel> {
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

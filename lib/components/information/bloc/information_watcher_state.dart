part of 'information_watcher_bloc.dart';

enum InformationFailure {
  error,
}

extension InformationFailureExtension on SomeFailure {
  InformationFailure toInformation() {
    return InformationFailure.error;
  }
}

@freezed
class InformationWatcherState with _$InformationWatcherState {
  const factory InformationWatcherState({
    required List<InformationModel> informationModelItems,
    required List<InformationModel> filteredInformationModelItems,
    required List<String>? filters,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required InformationFailure? failure,
  }) = _Initial;
}

extension InformationModelExtensions on List<InformationModel> {
  List<String> get overallTags {
    final allTags = <String>[];
    for (final item in this) {
      allTags.addAll(item.category);
    }
    return allTags.toSet().toList();
  }
}

part of 'information_watcher_bloc.dart';

enum LoadingStatus { initial, loading, loaded, error }

@freezed
class InformationWatcherState with _$InformationWatcherState {
  const factory InformationWatcherState({
    required List<InformationModel> informationModelItems,
    required List<InformationModel> filteredInformationModelItems,
    required String? filter,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
  }) = InformationWatcherStateSuccess;
}

extension InformationModelExtensions on List<InformationModel> {
  List<String> get overallTags {
    final allTags = <String>[];
    for (final item in this) {
      if (item.tags != null) {
        allTags.addAll(item.tags!);
      }
    }
    return allTags.toSet().toList();
  }
}

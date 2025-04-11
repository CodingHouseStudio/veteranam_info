part of 'information_watcher_bloc.dart';

// extension InformationFailureExtension on SomeFailure {
//   InformationFailure _toInformation() {
//     return InformationFailure.error;
//   }
// }

@freezed
sealed class InformationWatcherState with _$InformationWatcherState {
  const factory InformationWatcherState({
    required List<InformationModel> informationModelItems,
    required List<InformationModel> filteredInformationModelItems,
    required List<dynamic> filters,
    required LoadingStatus loadingStatus,
    required int itemsLoaded,
    required SomeFailure? failure,
    required bool isListLoadedFull,
    // required List<int> likeIndex,
    // required List<ReportModel> reportItems,
  }) = _Initial;
}

// extension InformationModelExtensions on List<InformationModel> {
//   List<String> get overallTagsBloc {
//     final allTags = <String>[];
//     for (final item in this) {
//       allTags.addAll(
//         item.category,
//       );
//     }
//     return allTags.toSet().toList();
//   }
// }

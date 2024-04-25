part of 'work_imployee_watcher_bloc.dart';

enum WorkFailure {
  error,
}

extension WorkFailureExtension on SomeFailure {
  WorkFailure toInformation() {
    return WorkFailure.error;
  }
}

@freezed
class WorkImployeeWatcherState with _$WorkImployeeWatcherState {
  const factory WorkImployeeWatcherState({
    required List<InformationModel> informationModelItems,
    required List<InformationModel> filteredInformationModelItems,
    required List<String>? filters,
    required LoadingStatus loadingStatus,
    required int page,
    required WorkFailure? failure,
  }) = WorkImployeeWatcherState;
}

extension InformationModelExtensions on List<WorkModel> {
  List<String> get overallCities {
    final allCities = <String>[];
    for (final item in this) {
      if (item.city != null) {
        allCities.add(item.city!);
      }
    }
    return allCities.toSet().toList();
  }

  List<String> get overallCategories {
    final allCategories = <String>[];
    for (final item in this) {
      if (item.category != null) {
        allCategories.add(item.category!);
      }
    }
    return allCategories.toSet().toList();
  }
}

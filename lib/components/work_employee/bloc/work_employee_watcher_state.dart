part of 'work_employee_watcher_bloc.dart';

enum WorkFailure {
  error,
}

extension WorkFailureExtension on SomeFailure {
  WorkFailure _toWork() {
    return WorkFailure.error;
  }
}

@freezed
class WorkEmployeeWatcherState with _$WorkEmployeeWatcherState {
  const factory WorkEmployeeWatcherState({
    required List<WorkModel> workModelItems,
    required List<WorkModel> filteredWorkModelItems,
    required String? category,
    required String? city,
    required LoadingStatus loadingStatus,
    required int page,
    required int maxPage,
    required WorkFailure? failure,
  }) = _Initial;
}

extension WorkModelExtensions on List<WorkModel> {
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

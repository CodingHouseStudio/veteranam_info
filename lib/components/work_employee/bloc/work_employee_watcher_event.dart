part of 'work_employee_watcher_bloc.dart';

@freezed
class WorkEmployeeWatcherEvent with _$WorkEmployeeWatcherEvent {
  const factory WorkEmployeeWatcherEvent.started() = _Started;

  const factory WorkEmployeeWatcherEvent.updated(
    List<WorkModel> workItemsModel,
  ) = _Updated;

  const factory WorkEmployeeWatcherEvent.loadPage(int page) = _LoadPage;

  const factory WorkEmployeeWatcherEvent.filterCategories({
    String? category,
  }) = _FilterCategories;

  const factory WorkEmployeeWatcherEvent.filterCities({
    String? city,
  }) = _FilterCities;

  const factory WorkEmployeeWatcherEvent.filterReset() = _FilterReset;

  const factory WorkEmployeeWatcherEvent.failure({
    required Object? error,
    required StackTrace stack,
  }) = _Failure;
}

part of 'work_imployee_watcher_bloc.dart';

@freezed
class WorkImployeeWatcherEvent with _$WorkImployeeWatcherEvent {
  const factory WorkImployeeWatcherEvent.started() = _Started;

  const factory WorkImployeeWatcherEvent.updated(
    List<InformationModel> informationItemsModel,
  ) = _Updated;

  const factory WorkImployeeWatcherEvent.loadNextItems() = _LoadNextPage;

  const factory WorkImployeeWatcherEvent.filter({
    String? filter,
    bool? isSelected,
  }) = _Filter;

  const factory WorkImployeeWatcherEvent.filterReset() = _FilterReset;

  const factory WorkImployeeWatcherEvent.failure(dynamic failure) = _Failure;
}

part of 'information_watcher_bloc.dart';

@freezed
class InformationWatcherEvent with _$InformationWatcherEvent {
  const factory InformationWatcherEvent.started() = _Started;

  const factory InformationWatcherEvent.updated(
    List<InformationModel> informationItemsModel,
    // required List<ReportModel> reportItems,
  ) = _Updated;

  const factory InformationWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory InformationWatcherEvent.filter(
    int filterIndex,
  ) = _Filter;

  // const factory InformationWatcherEvent.filterReset() = _FilterReset;

  const factory InformationWatcherEvent.failure(dynamic failure) = _Failure;

  // const factory InformationWatcherEvent.getReport() = _GetReport;

  const factory InformationWatcherEvent.like({
    required InformationModel informationModel,
    required bool isLiked,
  }) = _Like;

  const factory InformationWatcherEvent.changeLike({
    required InformationModel informationModel,
    required bool isLiked,
  }) = _ChangeLike;
}

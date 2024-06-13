part of 'information_watcher_bloc.dart';

@freezed
class InformationWatcherEvent with _$InformationWatcherEvent {
  const factory InformationWatcherEvent.started() = _Started;

  const factory InformationWatcherEvent.updated(
    List<InformationModel> informationItemsModel,
  ) = _Updated;

  const factory InformationWatcherEvent.loadNextItems() = _LoadNextItems;

  const factory InformationWatcherEvent.filter(
    int filterIndex,
  ) = _Filter;

  const factory InformationWatcherEvent.filterReset() = _FilterReset;

  const factory InformationWatcherEvent.failure(dynamic failure) = _Failure;
}

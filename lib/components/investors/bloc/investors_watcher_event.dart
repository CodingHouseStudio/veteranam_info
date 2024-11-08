part of 'investors_watcher_bloc.dart';

@freezed
class InvestorsWatcherEvent with _$InvestorsWatcherEvent {
  const factory InvestorsWatcherEvent.started() = _Started;
  // const factory InvestorsWatcherEvent.loadNextItems() = _LoadNextItems;

  // const factory InvestorsWatcherEvent.getReport() = _GetReport;
}

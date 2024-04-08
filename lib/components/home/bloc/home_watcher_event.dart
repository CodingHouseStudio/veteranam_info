part of 'home_watcher_bloc.dart';

@freezed
class HomeWatcherEvent with _$HomeWatcherEvent {
  const factory HomeWatcherEvent.started() = _Started;
}

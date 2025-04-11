part of 'home_watcher_bloc.dart';

@freezed
sealed class HomeWatcherEvent with _$HomeWatcherEvent {
  const factory HomeWatcherEvent.started() = _Started;
}

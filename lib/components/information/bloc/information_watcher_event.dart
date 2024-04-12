part of 'information_watcher_bloc.dart';

@freezed
class InformationWatcherEvent with _$InformationWatcherEvent {
  const factory InformationWatcherEvent.started() = _Started;
}
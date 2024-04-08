part of 'home_watcher_bloc.dart';

@freezed
class HomeWatcherEvent with _$HomeWatcherEvent {
  const factory HomeWatcherEvent.started() = _Started;
  const factory HomeWatcherEvent.updated({
    required List<QuestionModel> questionModelItems,
  }) = _Updated;
  const factory HomeWatcherEvent.failure() = _Failure;
}

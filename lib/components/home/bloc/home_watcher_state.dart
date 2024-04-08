part of 'home_watcher_bloc.dart';

@freezed
class HomeWatcherState with _$HomeWatcherState {
  const factory HomeWatcherState.initial() = HomeWatcherStateInitial;
  const factory HomeWatcherState.loading() = HomeWatcherStateLoading;
  const factory HomeWatcherState.success({
    required List<QuestionModel> questionModelItems,
  }) = HomeWatcherStateSuccess;
  const factory HomeWatcherState.failure() = HomeWatcherStateFailure;
}

part of 'information_watcher_bloc.dart';

@freezed
class InformationWatcherState with _$InformationWatcherState {
  const factory InformationWatcherState.initial() =
      InformationWatcherStateInitial;
  const factory InformationWatcherState.loading() =
      InformationWatcherStateLoading;
  const factory InformationWatcherState.success({
    required List<QuestionModel> questionModelItems,
  }) = InformationWatcherStateSuccess;
  const factory InformationWatcherState.failure() =
      InformationWatcherStateFailure;
}

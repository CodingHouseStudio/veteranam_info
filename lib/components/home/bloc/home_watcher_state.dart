part of 'home_watcher_bloc.dart';

enum HomeFailure {
  error,
}

extension HomeFailureExtension on SomeFailure {
  HomeFailure toHome() {
    return HomeFailure.error;
  }
}

@freezed
class HomeWatcherState with _$HomeWatcherState {
  const factory HomeWatcherState({
    required List<QuestionModel> questionModelItems,
    required LoadingStatus loadingStatus,
    HomeFailure? failure,
  }) = _Initial;
}

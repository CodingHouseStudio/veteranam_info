part of 'home_watcher_bloc.dart';

enum HomeFailure {
  error,
  get,
  network,
}

extension HomeFailureExtension on SomeFailure {
  HomeFailure _toHome() {
    switch (this) {
      case FailureGet():
        return HomeFailure.get;
      case FailureNetwork():
        return HomeFailure.network;
      default:
        return HomeFailure.error;
    }
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

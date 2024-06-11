part of 'home_watcher_bloc.dart';

enum HomeFailure {
  error,
  get,
  network,
}

extension HomeFailureValue on HomeFailure {
  String value(BuildContext context) {
    switch (this) {
      case HomeFailure.error:
        return context.l10n.error;
      case HomeFailure.get:
        return context.l10n.getFailure;
      case HomeFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension HomeFailureExtension on SomeFailure {
  HomeFailure toHome() {
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

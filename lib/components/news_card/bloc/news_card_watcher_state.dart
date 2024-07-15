part of 'news_card_watcher_bloc.dart';

enum NewsCardFailure {
  wrongID,
  error,
  get,
  network,
}

extension NewsCardExtension on SomeFailure {
  NewsCardFailure _toNewsCard() {
    switch (this) {
      case FailureGet():
        return NewsCardFailure.get;
      case FailureNetwork():
        return NewsCardFailure.network;
      default:
        return NewsCardFailure.error;
    }
  }
}

@freezed
class NewsCardWatcherState with _$NewsCardWatcherState {
  const factory NewsCardWatcherState({
    required InformationModel? informationModel,
    required LoadingStatus loadingStatus,
    required NewsCardFailure? failure,
  }) = _Initial;
}

part of 'mob_faq_watcher_bloc.dart';

enum MobFAQFailure {
  error,
  get,
  network,
}

extension MobFaqFailureExtension on SomeFailure {
  MobFAQFailure _toMobFAQ() {
    switch (this) {
      case FailureGet():
        return MobFAQFailure.get;
      case FailureNetwork():
        return MobFAQFailure.network;
      default:
        return MobFAQFailure.error;
    }
  }
}

@freezed
class MobFaqWatcherState with _$MobFaqWatcherState {
  const factory MobFaqWatcherState({
    required List<QuestionModel> questionModelItems,
    required LoadingStatus loadingStatus,
    MobFAQFailure? failure,
  }) = _Initial;
}

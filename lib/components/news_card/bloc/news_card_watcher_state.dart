part of 'news_card_watcher_bloc.dart';

// enum NewsCardFailure {
//   wrongID,
//   error,
//   get,
//   network,
//   notFound,
// }

// extension NewsCardExtension on SomeFailure {
//   NewsCardFailure _toNewsCard() {
//     switch (this) {
//       case FailureGet():
//         return NewsCardFailure.get;
//       case FailureNetwork():
//         return NewsCardFailure.network;
//       case FailureUserNotFound():
//         return NewsCardFailure.notFound;
//       default:
//         return NewsCardFailure.error;
//     }
//   }
// }

@freezed
sealed class NewsCardWatcherState with _$NewsCardWatcherState {
  const factory NewsCardWatcherState({
    required InformationModel? informationModel,
    required LoadingStatus loadingStatus,
    required SomeFailure? failure,
  }) = _Initial;
}

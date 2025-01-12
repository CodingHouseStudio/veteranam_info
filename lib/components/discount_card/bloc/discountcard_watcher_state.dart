part of 'discount_card_watcher_cubit.dart';

// enum DiscountCardFailure {
//   wrongID,
//   error,
//   get,
//   notFound,
//   network,
// }

// extension DiscountCardExtension on SomeFailure {
//   DiscountCardFailure _toDiscountCard() {
//     switch (this) {
//       case FailureGet():
//         return DiscountCardFailure.get;
//       case FailureNetwork():
//         return DiscountCardFailure.network;
//       case FailureUserNotFound():
//         return DiscountCardFailure.notFound;
//       default:
//         return DiscountCardFailure.error;
//     }
//   }
// }

@freezed
class DiscountCardWatcherState with _$DiscountCardWatcherState {
  const factory DiscountCardWatcherState({
    required DiscountModel? discountModel,
    required LoadingStatus loadingStatus,
    required SomeFailure? failure,
  }) = _Initial;
}

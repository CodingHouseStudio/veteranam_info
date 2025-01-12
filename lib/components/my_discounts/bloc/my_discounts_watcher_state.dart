part of 'my_discounts_watcher_bloc.dart';

// extension MyDiscountFailureExtension on SomeFailure {
//   MyDiscountFailure _toMyDiscount() {
//     switch (this) {
//       case FailureGet():
//         return MyDiscountFailure.get;
//       case FailureNetwork():
//         return MyDiscountFailure.network;
//       default:
//         return MyDiscountFailure.error;
//     }
//   }
// }

@freezed
class MyDiscountsWatcherState with _$MyDiscountsWatcherState {
  const factory MyDiscountsWatcherState({
    required List<DiscountModel> discountsModelItems,
    required List<DiscountModel> loadedDiscountsModelItems,
    required int itemsLoaded,
    required LoadingStatus loadingStatus,
    required bool isListLoadedFull,
    SomeFailure? failure,
  }) = _Initial;
}

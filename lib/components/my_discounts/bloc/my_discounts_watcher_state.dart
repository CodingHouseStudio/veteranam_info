part of 'my_discounts_watcher_bloc.dart';

enum MyDiscountFailure {
  error,
  get,
  network,
}

extension MyDiscountFailureExtension on SomeFailure {
  MyDiscountFailure toMyDiscount() {
    switch (this) {
      case FailureGet():
        return MyDiscountFailure.get;
      case FailureNetwork():
        return MyDiscountFailure.network;
      default:
        return MyDiscountFailure.error;
    }
  }
}

@freezed
class MyDiscountsWatcherState with _$MyDiscountsWatcherState {
  const factory MyDiscountsWatcherState({
    required List<DiscountModel> discountsModelItems,
    required LoadingStatus loadingStatus,
    MyDiscountFailure? failure,
  }) = _Initial;
}

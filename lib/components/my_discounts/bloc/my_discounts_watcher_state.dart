part of 'my_discounts_watcher_bloc.dart';

enum MyDiscountFailure {
  error,
  get,
  network,
}

extension MyDiscountFailureValue on MyDiscountFailure {
  String value(BuildContext context) {
    switch (this) {
      case MyDiscountFailure.error:
        return context.l10n.error;
      case MyDiscountFailure.get:
        return context.l10n.getFailure;
      case MyDiscountFailure.network:
        return context.l10n.networkFailure;
    }
  }
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

  // const factory MyDiscountsWatcherState.initial() =
  //     MyDiscountsWatcherStateInitial;
  // const factory MyDiscountsWatcherState.loading() =
  //     MyDiscountsWatcherStateLoading;
  // const factory MyDiscountsWatcherState.success({
  //   required List<DiscountModel> discountsModelItems,
  // }) = MyDiscountsWatcherStateSuccess;
  // const factory MyDiscountsWatcherState.failure(MyDiscountFailure failure) =
  //     MyDiscountsWatcherStateFailure;
}

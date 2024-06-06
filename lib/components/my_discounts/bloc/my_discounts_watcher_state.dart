part of 'my_discounts_watcher_bloc.dart';

enum MyDiscountFailure {
  error,
}

extension MyDiscountFailureExtension on SomeFailure {
  MyDiscountFailure toMyDiscount() {
    return MyDiscountFailure.error;
  }
}

@freezed
class MyDiscountsWatcherState with _$MyDiscountsWatcherState {
  const factory MyDiscountsWatcherState.initial() =
      MyDiscountsWatcherStateInitial;
  const factory MyDiscountsWatcherState.loading() =
      MyDiscountsWatcherStateLoading;
  const factory MyDiscountsWatcherState.success({
    required List<DiscountModel> discountsModelItems,
  }) = MyDiscountsWatcherStateSuccess;
  const factory MyDiscountsWatcherState.failure(MyDiscountFailure failure) =
      MyDiscountsWatcherStateFailure;
}

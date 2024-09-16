part of 'discounts_add_bloc.dart';

@freezed
class DiscountsAddState with _$DiscountsAddState {
  const factory DiscountsAddState({
    // required DiscountModel discountModel,
    required List<String> cityList,
    required List<String> categoryList,
  }) = _Initial;
}

part of 'discounts_add_bloc.dart';

@freezed
class DiscountsAddState with _$DiscountsAddState {
  const factory DiscountsAddState({
    // required DiscountModel discountModel,
    required List<String> cityList,
    required List<String> categoryList,
    required MessageFieldModel category,
    required CitiesFieldModel city,
    required MessageFieldModel period,
    required MessageFieldModel title,
    required DiscountsFieldModel discounts,
    required LinkFieldModel link,
    required MessageFieldModel description,
    required MessageFieldModel exclusions,
  }) = _Initial;
}

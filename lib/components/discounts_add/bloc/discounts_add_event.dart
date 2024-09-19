part of 'discounts_add_bloc.dart';

@freezed
class DiscountsAddEvent with _$DiscountsAddEvent {
  const factory DiscountsAddEvent.started() = _Started;
  const factory DiscountsAddEvent.categoryUpdate(String category) =
      _CategoryUpdate;
  const factory DiscountsAddEvent.cityUpdate(String city) = _CityUpdate;
  const factory DiscountsAddEvent.periodUpdate(String? period) = _PeriodUpdate;
  const factory DiscountsAddEvent.titleUpdate(String title) = _TitleUpdate;
  const factory DiscountsAddEvent.discountUpdate(int discount) =
      _DiscountUpdate;
  const factory DiscountsAddEvent.linkUpdate(String link) = _LinkUpdate;
  const factory DiscountsAddEvent.descriptionUpdate(String description) =
      _DescriptionUpdate;
  const factory DiscountsAddEvent.exclusionsUpdate(String exclusions) =
      _ExclusionsUpdate;
  const factory DiscountsAddEvent.send() = _Send;
}

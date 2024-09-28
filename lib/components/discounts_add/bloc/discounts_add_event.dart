part of 'discounts_add_bloc.dart';

@freezed
class DiscountsAddEvent with _$DiscountsAddEvent {
  const factory DiscountsAddEvent.started() = _Started;
  const factory DiscountsAddEvent.categoryUpdate(String category) =
      _CategoryUpdate;
  const factory DiscountsAddEvent.cityAdd(String city) = _CityAdd;
  const factory DiscountsAddEvent.cityRemove(String city) = _CityRemove;
  const factory DiscountsAddEvent.periodUpdate(Future<DateTime?> period) =
      _PeriodUpdate;
  const factory DiscountsAddEvent.indefinitelyUpdate() = _IndefinitelyUpdate;
  const factory DiscountsAddEvent.titleUpdate(String title) = _TitleUpdate;
  const factory DiscountsAddEvent.discountAddItem(String discount) =
      _DiscountAddItem;
  const factory DiscountsAddEvent.discountRemoveItem(String discount) =
      _DiscountRemoveItem;
  const factory DiscountsAddEvent.linkUpdate(String link) = _LinkUpdate;
  const factory DiscountsAddEvent.descriptionUpdate(String description) =
      _DescriptionUpdate;
  const factory DiscountsAddEvent.exclusionsUpdate(String exclusions) =
      _ExclusionsUpdate;
  const factory DiscountsAddEvent.back() = _Back;
  const factory DiscountsAddEvent.send() = _Send;
}

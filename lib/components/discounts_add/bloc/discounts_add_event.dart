part of 'discounts_add_bloc.dart';

@freezed
sealed class DiscountsAddEvent with _$DiscountsAddEvent {
  // const factory DiscountsAddEvent.started() = _Started;
  const factory DiscountsAddEvent.loadedDiscount({
    required DiscountModel? discount,
    required String? discountId,
  }) = _LoadedDiscount;
  const factory DiscountsAddEvent.categoryAdd(String category) = _CategoryAdd;
  const factory DiscountsAddEvent.categoryRemove(String category) =
      _CategoryRemove;
  const factory DiscountsAddEvent.cityAdd(String city) = _CityAdd;
  const factory DiscountsAddEvent.cityRemove(String city) = _CityRemove;
  const factory DiscountsAddEvent.onlineSwitch() = _OnlineSwitch;
  const factory DiscountsAddEvent.periodUpdate(Future<DateTime?> period) =
      _PeriodUpdate;
  const factory DiscountsAddEvent.indefinitelyUpdate() = _IndefinitelyUpdate;
  const factory DiscountsAddEvent.titleUpdate(String title) = _TitleUpdate;
  const factory DiscountsAddEvent.discountAddItem(String discount) =
      _DiscountAddItem;
  const factory DiscountsAddEvent.discountRemoveItem(String discount) =
      _DiscountRemoveItem;
  const factory DiscountsAddEvent.eligibilityAddItem(
    EligibilityEnum eligibility,
  ) = _EligibilityAddItem;
  const factory DiscountsAddEvent.eligibilityRemoveItem(
    EligibilityEnum eligibility,
  ) = _EligibilityRemoveItem;
  const factory DiscountsAddEvent.linkUpdate(String link) = _LinkUpdate;
  const factory DiscountsAddEvent.descriptionUpdate(String description) =
      _DescriptionUpdate;
  const factory DiscountsAddEvent.requirementsUpdate(String requirements) =
      _RequirementsUpdate;
  const factory DiscountsAddEvent.emailUpdate(String email) = _EmailUpdate;
  const factory DiscountsAddEvent.closeDialog() = _CloseDialog;
  const factory DiscountsAddEvent.back() = _Back;
  const factory DiscountsAddEvent.send() = _Send;
}

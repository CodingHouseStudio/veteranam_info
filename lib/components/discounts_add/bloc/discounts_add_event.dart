part of 'discounts_add_bloc.dart';

@freezed
class DiscountsAddEvent with _$DiscountsAddEvent {
  const factory DiscountsAddEvent.started() = _Started;
  const factory DiscountsAddEvent.updateCategory(String category) =
      _UpdateCategory;
  const factory DiscountsAddEvent.updateCity(String city) = _UpdateCity;
  const factory DiscountsAddEvent.updatePeriod(String period) = _UpdatePeriod;
  const factory DiscountsAddEvent.updateTitle(String title) = _UpdateTitle;
  const factory DiscountsAddEvent.updateDiscount(int discount) =
      _UpdateDiscount;
  const factory DiscountsAddEvent.updateLink(int link) = _UpdateLink;
  const factory DiscountsAddEvent.updateDescription(int description) =
      _UpdateDescription;
  const factory DiscountsAddEvent.updateExclusions(int exclusions) =
      _UpdatExclusions;
}

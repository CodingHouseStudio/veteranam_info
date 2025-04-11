part of 'discount_link_form_bloc.dart';

@freezed
sealed class DiscountLinkFormEvent with _$DiscountLinkFormEvent {
  const factory DiscountLinkFormEvent.updateLink(String link) = _UpdateLink;
  const factory DiscountLinkFormEvent.sendLink() = _SendLink;
}

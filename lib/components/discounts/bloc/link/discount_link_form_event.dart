part of 'discount_link_form_bloc.dart';

@freezed
class DiscountLinkFormEvent with _$DiscountLinkFormEvent {
  const factory DiscountLinkFormEvent.started() = _Started;
  const factory DiscountLinkFormEvent.updateLink(String link) = _UpdateLink;
  const factory DiscountLinkFormEvent.sendLink() = _SendLink;
}

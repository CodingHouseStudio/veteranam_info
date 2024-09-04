part of 'discount_user_email_form_bloc.dart';

@freezed
class DiscountUserEmailFormEvent with _$DiscountUserEmailFormEvent {
  const factory DiscountUserEmailFormEvent.started() = _Started;
  const factory DiscountUserEmailFormEvent.updatedEmail(String email) =
      _UpdateEmail;
  const factory DiscountUserEmailFormEvent.sendEmail() = _SendEmail;
  const factory DiscountUserEmailFormEvent.sendEmailAfterClose() =
      _SendEmailAfterClose;
}

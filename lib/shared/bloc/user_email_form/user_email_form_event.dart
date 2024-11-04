part of 'user_email_form_bloc.dart';

@freezed
class UserEmailFormEvent with _$UserEmailFormEvent {
  const factory UserEmailFormEvent.started() = _Started;
  const factory UserEmailFormEvent.updatedEmail(String email) = _UpdateEmail;
  const factory UserEmailFormEvent.sendEmail() = _SendEmail;
  const factory UserEmailFormEvent.sendEmailAfterClose() = _SendEmailAfterClose;
}

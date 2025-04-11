part of 'sign_up_bloc.dart';

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.emailUpdated(
    String email,
  ) = _EmailUpdated;

  const factory SignUpEvent.passwordUpdated(String password) = _PasswordUpdated;

  const factory SignUpEvent.signUpSubmitted() = _SignUpSubmitted;

  const factory SignUpEvent.reset() = _SignUpReset;

  const factory SignUpEvent.passwordFieldHide() = _PasswordFieldHide;
}

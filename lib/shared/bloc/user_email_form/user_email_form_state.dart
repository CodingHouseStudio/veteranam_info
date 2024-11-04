part of 'user_email_form_bloc.dart';

enum UserEmailFormFailure {
  error,
  send,
  network,
}

// extension DiscountUserEmailFormFailureExtension on SomeFailure {
//   DiscountUserEmailFormFailure _toDiscountUserEmailForm() {
//     switch (this) {
//       case FailureSend():
//         return DiscountUserEmailFormFailure.send;
//       case FailureNetwork():
//         return DiscountUserEmailFormFailure.network;
//       default:
//         return DiscountUserEmailFormFailure.error;
//     }
//   }
// }

@freezed
class UserEmailFormState with _$UserEmailFormState {
  const factory UserEmailFormState({
    required EmailFieldModel email,
    required EmailEnum formState,
    required UserEmailEnum emailEnum,
    // int? count,
    //DiscountUserEmailFormFailure? failure,
  }) = _Initial;
}

enum EmailEnum {
  initial,
  inProgress,
  success,
  invalidData, //close
}

enum UserEmailEnum {
  initial(),
  discountEmailNotShow(),
  discountEmailAbandon(text: 'discount_email_abandon'),
  discountEmailAbandonSecondary(text: 'discount_email_abandon_secondary'),
  discountEmailAbandonRepeat(text: 'discount_email_abandon_repeat');

  const UserEmailEnum({this.text});

  final String? text;

  static UserEmailEnum get(int count) {
    if (count < 0) {
      return UserEmailEnum.discountEmailNotShow;
    }
    switch (count) {
      case 0:
        return UserEmailEnum.discountEmailAbandon;
      case 1:
        return UserEmailEnum.discountEmailAbandonSecondary;
      default:
        return UserEmailEnum.discountEmailAbandonRepeat;
    }
  }

  bool get show =>
      this != UserEmailEnum.initial &&
      this != UserEmailEnum.discountEmailNotShow;

  bool get closeEnable => show && this == UserEmailEnum.discountEmailAbandon;
}

part of 'discount_user_email_form_bloc.dart';

enum DiscountUserEmailFormFailure {
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
class DiscountUserEmailFormState with _$DiscountUserEmailFormState {
  const factory DiscountUserEmailFormState({
    required EmailFieldModel email,
    required EmailEnum formState,
    //DiscountUserEmailFormFailure? failure,
  }) = _Initial;
}

enum EmailEnum { initial, inProgress, success, invalidData, close }

part of 'mob_feedback_bloc.dart';

// enum MobFeedbackFailure {
//   error,
//   // network,
//   // send,
// }

// extension MobFeedbackFailureExtension on SomeFailure {
//   MobFeedbackFailure _toMobFeedback() {
//     switch (this) {
//       // case FailureSend():
//       //   return ReportFailure.send;
//       // case FailureNetwork():
//       //   return ReportFailure.network;
//       default:
//         return MobFeedbackFailure.error;
//     }
//   }
// }

@freezed
class MobFeedbackState with _$MobFeedbackState {
  const factory MobFeedbackState({
    required MessageFieldModel message,
    required SomeFailure? failure,
    required MobFeedbackEnum formState,
  }) = _Initial;
}

enum MobFeedbackEnum {
  initial,
  inProgress,
  success,
  invalidData,
}

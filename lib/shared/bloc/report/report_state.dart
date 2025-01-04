part of 'report_bloc.dart';

enum ReportFailure {
  error,
  // network,
  // send,
}

// extension ReportFailureExtension on SomeFailure {
//   ReportFailure _toReport() {
//     switch (this) {
//       // case FailureSend():
//       //   return ReportFailure.send;
//       // case FailureNetwork():
//       //   return ReportFailure.network;
//       default:
//         return ReportFailure.error;
//     }
//   }
// }

@freezed
class ReportState with _$ReportState {
  const factory ReportState({
    required ReasonComplaint? reasonComplaint,
    required EmailFieldModel email,
    required ReportFieldModel message,
    required ReportEnum formState,
    required ReportFailure? failure,
    required String cardId,
  }) = _Initial;
}

enum ReportEnum {
  initial,
  inProgress,
  success,
  invalidData,
  next,
  nextInProgress,
  nextInvalidData,
  trySuccessWithoutEmail,
}

extension ReportEnumExtension on ReportEnum {
  bool get isNext =>
      this == ReportEnum.next ||
      this == ReportEnum.nextInProgress ||
      this == ReportEnum.nextInvalidData;
}

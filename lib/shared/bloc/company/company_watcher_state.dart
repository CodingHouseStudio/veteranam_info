part of 'company_watcher_bloc.dart';

// enum CompanyWatcherFailure {
//   error,
//   // network,
//   // send,
// }

// extension CompanyWatcherFailureExtension on SomeFailure {
//   CompanyWatcherFailure _toCompany() {
//     switch (this) {
//       // case FailureSend():
//       //   return ReportFailure.send;
//       // case FailureNetwork():
//       //   return ReportFailure.network;
//       default:
//         return CompanyWatcherFailure.error;
//     }
//   }
// }

@freezed
class CompanyWatcherState with _$CompanyWatcherState {
  const factory CompanyWatcherState({
    required CompanyModel company,
    required SomeFailure? failure,
  }) = _Initial;
}

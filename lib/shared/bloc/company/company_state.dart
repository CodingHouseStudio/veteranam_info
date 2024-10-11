part of 'company_bloc.dart';

enum CompanyFailure {
  error,
  // network,
  // send,
}

extension CompanyFailureExtension on SomeFailure {
  CompanyFailure _toCompany() {
    switch (this) {
      // case FailureSend():
      //   return ReportFailure.send;
      // case FailureNetwork():
      //   return ReportFailure.network;
      default:
        return CompanyFailure.error;
    }
  }
}

@freezed
class CompanyState with _$CompanyState {
  const factory CompanyState({
    required CompanyModel company,
    required CompanyFailure? failure,
  }) = _Initial;
}

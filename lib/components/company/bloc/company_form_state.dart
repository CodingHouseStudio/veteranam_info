part of 'company_form_bloc.dart';

enum CompanyFormFailure {
  error,
  network,
  send,
}

extension CompanyFormFailureExtension on SomeFailure {
  CompanyFormFailure _toCompanyError() => CompanyFormFailure.error;
}

@freezed
class CompanyFormState with _$CompanyFormState {
  const factory CompanyFormState({
    required CompanyNameFieldModel companyName,
    required CompanyCodeFieldModel code,
    required ImageFieldModel image,
    required LinkFieldModel link,
    required CompanyFormFailure? failure,
    required CompanyFormEnum formState,
    required bool? deleteIsPossible,
  }) = _CompanyFormState;
}

enum CompanyFormEnum {
  initial,
  inProgress,
  invalidData,
  delete,
  success,
  succesesUnmodified,
  sendInProgress;
}

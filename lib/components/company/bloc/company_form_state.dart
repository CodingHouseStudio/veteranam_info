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
  }) = _CompanyFormState;
}

enum CompanyFormEnum {
  initial,
  inProgress,
  invalidData,
  success,
  succesesUnmodified,
  sendInProgress;

  bool get showMessage =>
      this == CompanyFormEnum.success ||
      this == CompanyFormEnum.sendInProgress ||
      this == CompanyFormEnum.succesesUnmodified;
}

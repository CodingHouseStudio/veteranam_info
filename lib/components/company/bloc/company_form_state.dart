part of 'company_form_bloc.dart';

// extension CompanyFormFailureExtension on SomeFailure {
//   CompanyFormFailure _toCompanyError() => CompanyFormFailure.error;
// }

@freezed
sealed class CompanyFormState with _$CompanyFormState {
  const factory CompanyFormState({
    required CompanyNameFieldModel companyName,
    required PublicNameFieldModel publicName,
    required CompanyCodeFieldModel code,
    required ImageFieldModel image,
    required LinkFieldModel link,
    required SomeFailure? failure,
    required CompanyFormEnum formState,
    required bool? deleteIsPossible,
  }) = _CompanyFormState;
}

enum CompanyFormEnum {
  initial,
  inProgress,
  invalidData,
  // delete,
  success,
  succesesUnmodified,
  sendInProgress;
}

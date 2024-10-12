part of 'company_form_bloc.dart';

@freezed
class CompanyFormEvent with _$CompanyFormEvent {
  const factory CompanyFormEvent.started() = _Started;

  const factory CompanyFormEvent.companyNameUpdated(
    String companyName,
  ) = _CompanyNameUpdated;

  const factory CompanyFormEvent.codeUpdated(
    String code,
  ) = _CodeUpdated;

  const factory CompanyFormEvent.linkUpdated(
    String link,
  ) = _LinkUpdated;

  const factory CompanyFormEvent.imageUpdated() = _ImageUpdated;

  const factory CompanyFormEvent.deleteCompany() = _DeleteCompany;

  const factory CompanyFormEvent.save() = _Save;
}

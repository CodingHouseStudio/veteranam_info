part of 'company_bloc.dart';

@freezed
class CompanyEvent with _$CompanyEvent {
  const factory CompanyEvent.started() = _Started;
  const factory CompanyEvent.updated(CompanyModel company) = _Updated;
  const factory CompanyEvent.deleteCompany() = _DeleteCompany;
  const factory CompanyEvent.failure({
    required Object? error,
    required StackTrace stack,
  }) = _Failure;
}

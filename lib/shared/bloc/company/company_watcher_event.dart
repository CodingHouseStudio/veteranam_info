part of 'company_watcher_bloc.dart';

@freezed
sealed class CompanyWatcherEvent with _$CompanyWatcherEvent {
  // const factory CompanyWatcherEvent.started() = _Started;
  const factory CompanyWatcherEvent.updated(CompanyModel company) = _Updated;
  const factory CompanyWatcherEvent.failure({
    required Object error,
    required StackTrace stack,
  }) = _Failure;
}

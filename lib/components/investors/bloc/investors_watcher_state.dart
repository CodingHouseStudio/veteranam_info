part of 'investors_watcher_bloc.dart';

enum InvestorsFailure {
  error,
}

extension InvestorsFailureExtension on SomeFailure {
  InvestorsFailure toInvestors() {
    return InvestorsFailure.error;
  }
}

@freezed
class InvestorsWatcherState with _$InvestorsWatcherState {
  const factory InvestorsWatcherState.initial() = InvestorsWatcherStateIntital;
  const factory InvestorsWatcherState.loading() = InvestorsWatcherStateLoading;
  const factory InvestorsWatcherState.success({
    required List<FundModel> fundItems,
  }) = InvestorsWatcherStateSuccess;
  const factory InvestorsWatcherState.failure(InvestorsFailure failure) =
      InvestorsWatcherStateFailure;
}

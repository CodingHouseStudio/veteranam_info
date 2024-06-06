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
  const factory InvestorsWatcherState({
    required List<FundModel> fundItems,
    required LoadingStatus loadingStatus,
    InvestorsFailure? failure,
  }) = _Initial;
}

part of 'investors_watcher_bloc.dart';

enum InvestorsFailure {
  error,
  get,
  network,
}

extension InvestorsFailureValue on InvestorsFailure {
  String value(BuildContext context) {
    switch (this) {
      case InvestorsFailure.error:
        return context.l10n.error;
      case InvestorsFailure.get:
        return context.l10n.getFailure;
      case InvestorsFailure.network:
        return context.l10n.networkFailure;
    }
  }
}

extension InvestorsFailureExtension on SomeFailure {
  InvestorsFailure toInvestors() {
    switch (this) {
      case FailureGet():
        return InvestorsFailure.get;
      case FailureNetwork():
        return InvestorsFailure.network;
      default:
        return InvestorsFailure.error;
    }
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

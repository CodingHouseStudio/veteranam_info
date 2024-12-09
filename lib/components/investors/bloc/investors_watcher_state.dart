part of 'investors_watcher_bloc.dart';

extension InvestorsFailureExtension on SomeFailure {
  InvestorsFailure _toInvestors() {
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
    required List<FundModel> mobFundItems,
    required List<List<FundModel>> deskFundItems,
    // required List<FundModel> loadingMobFundItems,
    required LoadingStatus loadingStatus,
    // required bool loadedFull,
    // required int itemsLoaded,
    // required List<ReportModel> reportItems,
    required InvestorsFailure? failure,
  }) = _Initial;
}

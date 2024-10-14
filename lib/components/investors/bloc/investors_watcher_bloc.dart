import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'investors_watcher_bloc.freezed.dart';
part 'investors_watcher_event.dart';
part 'investors_watcher_state.dart';

@Injectable(env: [Config.user])
class InvestorsWatcherBloc
    extends Bloc<InvestorsWatcherEvent, InvestorsWatcherState> {
  InvestorsWatcherBloc({
    required IInvestorsRepository investorsRepository,
    // required IReportRepository reportRepository,
    // required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _investorsRepository = investorsRepository,
        // _reportRepository = reportRepository,
        // _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const InvestorsWatcherState(
            fundItems: [],
            loadingStatus: LoadingStatus.initial,
            loadingFundItems: [],
            itemsLoaded: 0,
            // reportItems: [],
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_LoadNextItems>(_loadNextItems);
    // on<_GetReport>(_onGetReport);
  }
  final IInvestorsRepository _investorsRepository;
  // final IReportRepository _reportRepository;
  // final IAppAuthenticationRepository _appAuthenticationRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    // final reportItems = await _getReport();

    final result = await _investorsRepository.getFunds(
        // reportIdItems: reportItems?.getIdCard,
        );
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toInvestors(),
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) {
        // final list = r.removeReportItems(
        //   checkFunction: (item) => item.id,
        //   reportItems: reportItems,
        // );
        emit(
          InvestorsWatcherState(
            fundItems: r,
            loadingStatus: r.length > KDimensions.investorsLoadItems
                ? LoadingStatus.loaded
                : LoadingStatus.listLoadedFull,
            loadingFundItems: _loading(
              itemsLoaded: state.itemsLoaded,
              loadItems: KDimensions.investorsLoadItems,
              // reportItems: reportItems,
              list: r,
            ),
            itemsLoaded: KDimensions.investorsLoadItems,
            // reportItems: reportItems,
            failure: null,
          ),
        );
      },
    );
  }

  Future<void> _loadNextItems(
    _LoadNextItems event,
    Emitter<InvestorsWatcherState> emit,
  ) async {
    if (state.itemsLoaded.checkLoadingPosible(state.fundItems)) {
      emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
      return;
    }

    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final filterItems = _loading(
      itemsLoaded: state.itemsLoaded,
      loadItems: KDimensions.investorsLoadItems,
    );

    emit(
      state.copyWith(
        loadingFundItems: filterItems,
        itemsLoaded:
            (state.itemsLoaded + KDimensions.investorsLoadItems).getLoaded(
          list: filterItems,
          loadItems: KDimensions.investorsLoadItems,
        ),
        loadingStatus: filterItems.length == state.fundItems.length
            ? LoadingStatus.listLoadedFull
            : LoadingStatus.loaded,
      ),
    );
  }

  // Future<void> _onGetReport(
  //   _GetReport event,
  //   Emitter<InvestorsWatcherState> emit,
  // ) async {
  //   final reportItems = await _getReport();
  //   final list = state.fundItems.removeReportItems(
  //     checkFunction: (item) => item.id,
  //     reportItems: reportItems,
  //   );

  //   emit(
  //     state.copyWith(
  //       reportItems: reportItems,
  //       loadingFundItems: _filter(
  //         itemsLoaded: state.itemsLoaded,
  //         loadItems: null,
  //         reportItems: reportItems,
  //         list: list,
  //       ),
  //       fundItems: list,
  //     ),
  //   );
  // }

  // Future<List<ReportModel>?> _getReport() async {
  //   final reportItems = await _reportRepository.getCardReportById(
  //     cardEnum: CardEnum.funds,
  //     userId: _appAuthenticationRepository.currentUser.id,
  //   );
  //   return reportItems.fold(
  //     (l) => null,
  //     (r) => r.isEmpty ? null : r,
  //   );
  // }

  List<FundModel> _loading({
    required int itemsLoaded,
    required int? loadItems,
    List<FundModel>? list,
    // List<ReportModel>? reportItems,
  }) {
    // final reportItemsValue = reportItems ?? state.reportItems;
    return (list ?? state.fundItems)
        // .where(
        //   (item) => reportItemsValue.every(
        //     (report) => report.cardId != item.id,
        //   ),
        // )
        // .toList()
        .loading(
      itemsLoaded: itemsLoaded,
      loadItems: loadItems,
    );
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

part 'information_watcher_bloc.freezed.dart';
part 'information_watcher_event.dart';
part 'information_watcher_state.dart';

@Injectable(env: [Config.development])
class InformationWatcherBloc
    extends Bloc<InformationWatcherEvent, InformationWatcherState> {
  InformationWatcherBloc({
    required IInformationRepository informationRepository,
    // required IReportRepository reportRepository,
    // required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _informationRepository = informationRepository,
        // _reportRepository = reportRepository,
        // _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const InformationWatcherState(
            informationModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredInformationModelItems: [],
            filters: [],
            itemsLoaded: 0,
            failure: null, isListLoadedFull: false,
            // reportItems: [],
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_Filter>(_onFilter);
    // on<_GetReport>(_onGetReport);
    // on<_FilterReset>(_onFilterReset);
    on<_Like>(_onLike);
    on<_ChangeLike>(_onChangeLike);
  }

  final IInformationRepository _informationRepository;
  StreamSubscription<List<InformationModel>>? _informationItemsSubscription;
  // final IReportRepository _reportRepository;
  // final IAppAuthenticationRepository _appAuthenticationRepository;
  Timer? _debounceTimer;

  Future<void> _onStarted(
    _Started event,
    Emitter<InformationWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    // final reportItems = await _getReport();

    await _informationItemsSubscription?.cancel();
    _informationItemsSubscription = _informationRepository
        .getInformationItems(
            // reportIdItems: reportItems?.getIdCard,
            )
        .listen(
      (information) => add(
        InformationWatcherEvent.updated(
          information,
          // reportItems: reportItems,
        ),
      ),
      onError: (Object error, StackTrace stack) {
        add(InformationWatcherEvent.failure(error: error, stack: stack));
      },
    );
  }

  void _onUpdated(
    _Updated event,
    Emitter<InformationWatcherState> emit,
  ) {
    if (event.informationItemsModel.isEmpty && Config.isProduction) return;
    // final items = event.informationItemsModel.removeReportItems(
    //   checkFunction: (item) => item.id,
    //   reportItems: event.reportItems,
    // );
    final (:list, :isListLoadedFull) = _filter(
      filters: state.filters,
      itemsLoaded: state.itemsLoaded,
      list: event.informationItemsModel,
      // reportItems: event.reportItems,
    );
    emit(
      InformationWatcherState(
        informationModelItems: event.informationItemsModel,
        loadingStatus: LoadingStatus.loaded, isListLoadedFull: isListLoadedFull,
        filteredInformationModelItems: list,
        filters: state.filters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        failure: null,
        // reportItems: event.reportItems,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<InformationWatcherState> emit,
  ) {
    if (state.itemsLoaded.checkLoadingPosible(state.informationModelItems)) {
      emit(state.copyWith(isListLoadedFull: true));
      return;
    }
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final (:list, :isListLoadedFull) = _filter(
      filters: state.filters,
      itemsLoaded: state.itemsLoaded,
      loadItems: KDimensions.loadItems,
    );
    emit(
      state.copyWith(
        filteredInformationModelItems: list,
        itemsLoaded: list.length,
        loadingStatus: LoadingStatus.loaded,
        isListLoadedFull: isListLoadedFull,
      ),
    );
  }

  // void _onFilterReset(
  //   _FilterReset event,
  //   Emitter<InformationWatcherState> emit,
  // ) {
  //   emit(
  //     state.copyWith(
  //       filteredInformationModelItems: state.informationModelItems.loading(
  //         itemsLoaded: state.itemsLoaded,
  //       ),
  //       filters: null,
  //     ),
  //   );
  // }

  void _onFilter(
    _Filter event,
    Emitter<InformationWatcherState> emit,
  ) {
    final selectedFilters = state.filters.changeListValue(
      eventFilter: event.value,
      removeValue: CategoryEnum.all,
    );

    final (:list, :isListLoadedFull) = _filter(
      filters: selectedFilters,
      itemsLoaded: state.itemsLoaded,
    );

    emit(
      state.copyWith(
        filteredInformationModelItems: list,
        filters: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        isListLoadedFull: isListLoadedFull,
      ),
    );
  }

  ({
    List<InformationModel> list,
    bool isListLoadedFull,
  }) _filter({
    required List<dynamic>? filters,
    required int itemsLoaded,
    List<InformationModel>? list,
    // List<ReportModel>? reportItems,
    int? loadItems,
  }) {
    // final reportItemsValue = reportItems ?? state.reportItems;
    return (list ?? state.informationModelItems)
        // .where(
        //   (item) => reportItemsValue.every(
        //     (report) => report.cardId != item.id,
        //   ),
        // )
        // .toList()
        .loadingFilterAndStatus(
      filtersValue: filters,
      itemsLoaded: itemsLoaded,
      getFilter: (InformationModel item) => item.categoryUA,
      loadItems: loadItems,
    );
  }

  // Future<void> _onGetReport(
  //   _GetReport event,
  //   Emitter<InformationWatcherState> emit,
  // ) async {
  //   final reportItems = await _getReport();
  //   final items = state.informationModelItems.removeReportItems(
  //     checkFunction: (item) => item.id,
  //     reportItems: reportItems,
  //   );

  //   final filters = items.updateFilterList(
  //     getFilter: (item) => item.category,
  //     previousList: state.informationModelItems,
  //     previousFilter: state.filters,
  //   );
  //   final (:list, :loadingStatus) = _filter(
  //     filters: filters,
  //     itemsLoaded: state.itemsLoaded,
  //     list: items,
  //   );

  //   emit(
  //     state.copyWith(
  //       reportItems: reportItems,
  //       informationModelItems: items,
  //       filteredInformationModelItems: list,
  //       filters: filters,
  //       loadingStatus: loadingStatus,
  //     ),
  //   );
  // }

  // Future<List<ReportModel>?> _getReport() async {
  //   final reportItems = await _reportRepository.getCardReportById(
  //     cardEnum: CardEnum.information,
  //     userId: _appAuthenticationRepository.currentUser.id,
  //   );
  //   return reportItems.fold(
  //     (l) => null,
  //     (r) => r.isEmpty ? null : r,
  //   );
  // }

  Future<void> _onLike(
    _Like event,
    Emitter<InformationWatcherState> emit,
  ) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
      _debounceTimer = null;
      return;
    }
    if (!(_debounceTimer?.isActive ?? false)) {
      _debounceTimer = Timer(Duration(seconds: KTest.isTest ? 0 : 5), () async {
        add(
          InformationWatcherEvent.changeLike(
            informationModel: event.informationModel,
            isLiked: event.isLiked,
          ),
        );
      });
    }
  }

  Future<void> _onChangeLike(
    _ChangeLike event,
    Emitter<InformationWatcherState> emit,
  ) async {
    final result = await _informationRepository.updateLikeCount(
      informationModel: event.informationModel,
      isLiked: event.isLiked,
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l,
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          failure: null,
          loadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }

  // EasyDebounce.debounce(
  //   'change like',
  //   const Duration(seconds: 5),
  //   () => _informationRepository.updateLikeCount(
  //     informationModel: event.informationModel,
  //     isLiked: event.isLiked,
  //   ),
  // );
  // final stream = Stream.periodic(const Duration(seconds: 5), (i) => i)
  //     .take(1)
  //     .asyncMap((_) async {
  //   final result = await _informationRepository.updateLikeCount(
  //     informationModel: event.informationModel,
  //     isLiked: event.isLiked,
  //   );

  //   result.fold(
  //     (l) => emit(
  //       state.copyWith(
  //         failure: InformationFailure.error,
  //         loadingStatus: LoadingStatus.error,
  //       ),
  //     ),
  //     (r) => emit(
  //       state.copyWith(
  //         failure: null,
  //         loadingStatus: LoadingStatus.loaded,
  //       ),
  //     ),
  //   );
  // });

  // stream.throttle(const Duration(seconds: 5)).listen((_) {});

  void _onFailure(
    _Failure event,
    Emitter<InformationWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: SomeFailure.value(
          error: event.error,
          stack: event.stack,
          tag: 'Information ${ErrorText.watcherBloc}',
          tagKey: ErrorText.streamBlocKey,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _informationItemsSubscription?.cancel();
    _debounceTimer?.cancel();
    // _debounceTimer = null;
    return super.close();
  }
}

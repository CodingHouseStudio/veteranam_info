import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'information_watcher_bloc.freezed.dart';
part 'information_watcher_event.dart';
part 'information_watcher_state.dart';

@Injectable()
class InformationWatcherBloc
    extends Bloc<InformationWatcherEvent, InformationWatcherState> {
  InformationWatcherBloc({
    required IInformationRepository informationRepository,
    required IReportRepository reportRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _informationRepository = informationRepository,
        _reportRepository = reportRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const InformationWatcherState(
            informationModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredInformationModelItems: [],
            filtersIndex: [],
            itemsLoaded: 0,
            failure: null,
            reportItems: [],
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_Filter>(_onFilter);
    on<_GetReport>(_onGetReport);
    // on<_FilterReset>(_onFilterReset);
    on<_Like>(_onLike);
    on<_ChangeLike>(_onChangeLike);
  }

  final IInformationRepository _informationRepository;
  StreamSubscription<List<InformationModel>>? _informationItemsSubscription;
  final IReportRepository _reportRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;
  Timer? _debounceTimer;

  Future<void> _onStarted(
    _Started event,
    Emitter<InformationWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final reportItems = await _getReport();

    await _informationItemsSubscription?.cancel();
    _informationItemsSubscription =
        _informationRepository.getInformationItems().listen(
      (information) => add(
        InformationWatcherEvent.updated(
          informationItemsModel: information,
          reportItems: reportItems,
        ),
      ),
      onError: (dynamic error) {
        // debugPrint('error is $error');
        add(InformationWatcherEvent.failure(error));
      },
    );
  }

  void _onUpdated(
    _Updated event,
    Emitter<InformationWatcherState> emit,
  ) {
    emit(
      InformationWatcherState(
        informationModelItems: event.informationItemsModel,
        loadingStatus: LoadingStatus.loaded,
        filteredInformationModelItems: _filter(
          filtersIndex: state.filtersIndex,
          itemsLoaded: state.itemsLoaded,
          list: event.informationItemsModel,
          reportItems: event.reportItems,
        ),
        filtersIndex: state.filtersIndex,
        itemsLoaded:
            state.itemsLoaded.getLoaded(list: event.informationItemsModel),
        failure: null,
        reportItems: event.reportItems,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<InformationWatcherState> emit,
  ) {
    if (state.itemsLoaded.checkLoadingPosible(state.informationModelItems)) {
      emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
      return;
    }
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final filterItems = _filter(
      filtersIndex: state.filtersIndex,
      itemsLoaded: state.itemsLoaded,
      loadItems: KDimensions.loadItems,
    );
    emit(
      state.copyWith(
        filteredInformationModelItems: filterItems,
        itemsLoaded: filterItems.length,
        loadingStatus:
            filterItems.isLoading(state.filteredInformationModelItems),
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
  //       filtersIndex: null,
  //     ),
  //   );
  // }

  void _onFilter(
    _Filter event,
    Emitter<InformationWatcherState> emit,
  ) {
    final selectedFilters =
        state.filtersIndex.changeListValue(event.filterIndex);

    final filterItems = _filter(
      filtersIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
    );

    emit(
      state.copyWith(
        filteredInformationModelItems: filterItems,
        filtersIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: filterItems),
        loadingStatus:
            filterItems.isLoadingFilter(state.filteredInformationModelItems),
      ),
    );
  }

  List<InformationModel> _filter({
    required List<int>? filtersIndex,
    required int itemsLoaded,
    List<InformationModel>? list,
    List<ReportModel>? reportItems,
    int? loadItems,
  }) {
    final reportItemsValue = reportItems ?? state.reportItems;
    return (list ?? state.informationModelItems)
        .where(
          (item) => reportItemsValue.every(
            (report) => report.cardId != item.id,
          ),
        )
        .toList()
        .loadingFilter(
          filtersIndex: filtersIndex,
          itemsLoaded: itemsLoaded,
          getFilter: (InformationModel item) => item.category,
          loadItems: loadItems,
        );
  }

  Future<void> _onGetReport(
    _GetReport event,
    Emitter<InformationWatcherState> emit,
  ) async {
    final reportItems = await _getReport();

    emit(
      state.copyWith(
        reportItems: reportItems,
        filteredInformationModelItems: _filter(
          filtersIndex: state.filtersIndex,
          itemsLoaded: state.itemsLoaded,
          reportItems: reportItems,
        ),
      ),
    );
  }

  Future<List<ReportModel>> _getReport() async {
    final reportItems = await _reportRepository.getCardReportById(
      cardEnum: CardEnum.information,
      userId: _appAuthenticationRepository.currentUser.id,
    );
    return reportItems.fold(
      (l) => [],
      (r) => r,
    );
  }

  void _onFailure(
    _Failure event,
    Emitter<InformationWatcherState> emit,
  ) {
    // debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: InformationFailure.error,
      ),
    );
  }

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
      _debounceTimer = Timer(const Duration(seconds: 5), () async {
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
          failure: InformationFailure.error,
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

  @override
  Future<void> close() {
    _informationItemsSubscription?.cancel();
    return super.close();
  }
}

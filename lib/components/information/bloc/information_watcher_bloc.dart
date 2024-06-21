import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'information_watcher_event.dart';

part 'information_watcher_state.dart';

part 'information_watcher_bloc.freezed.dart';

@Injectable()
class InformationWatcherBloc
    extends Bloc<InformationWatcherEvent, InformationWatcherState> {
  InformationWatcherBloc({
    required IInformationRepository informationRepository,
  })  : _informationRepository = informationRepository,
        super(
          const _Initial(
            informationModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredInformationModelItems: [],
            filtersIndex: null,
            itemsLoaded: 0,
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_Filter>(_onFilter);
    // on<_FilterReset>(_onFilterReset);
  }

  final IInformationRepository _informationRepository;
  StreamSubscription<List<InformationModel>>? _informationItemsSubscription;

  Future<void> _onStarted(
    _Started event,
    Emitter<InformationWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    await _informationItemsSubscription?.cancel();
    _informationItemsSubscription =
        _informationRepository.getInformationItems().listen(
      (information) => add(
        InformationWatcherEvent.updated(
          information,
        ),
      ),
      onError: (dynamic error) {
        debugPrint('error is $error');
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
        ),
        filtersIndex: state.filtersIndex,
        itemsLoaded:
            state.itemsLoaded.getLoaded(list: event.informationItemsModel),
        failure: null,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<InformationWatcherState> emit,
  ) {
    if (state.itemsLoaded.checkLoadingPosible(state.informationModelItems)) {
      return;
    }
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final filterItems = _filter(
      filtersIndex: state.filtersIndex,
      itemsLoaded: state.itemsLoaded + KDimensions.loadItems,
    );
    emit(
      state.copyWith(
        filteredInformationModelItems: filterItems,
        itemsLoaded: (state.itemsLoaded + KDimensions.loadItems)
            .getLoaded(list: filterItems),
        loadingStatus: LoadingStatus.loaded,
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
    final selectedFilters = state.filtersIndex.filterIndex(event.filterIndex);

    final filterItems = _filter(
      filtersIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
    );

    emit(
      state.copyWith(
        filteredInformationModelItems: filterItems,
        filtersIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: filterItems),
      ),
    );
  }

  List<InformationModel> _filter({
    required List<int>? filtersIndex,
    required int itemsLoaded,
    List<InformationModel>? list,
  }) {
    return (list ?? state.informationModelItems).loadingFilter(
      filtersIndex: filtersIndex,
      itemsLoaded: itemsLoaded,
      getFilter: (InformationModel item) => item.category,
    );
  }

  void _onFailure(
    _Failure event,
    Emitter<InformationWatcherState> emit,
  ) {
    debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: InformationFailure.error,
      ),
    );
  }

  @override
  Future<void> close() {
    _informationItemsSubscription?.cancel();
    return super.close();
  }
}

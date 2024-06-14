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
    on<_FilterReset>(_onFilterReset);
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
          itemsLoaded: state.itemsLoaded.getLoaded,
          informationModelItems: event.informationItemsModel,
        ),
        filtersIndex: state.filtersIndex,
        itemsLoaded: event.informationItemsModel.isNotEmpty
            ? state.itemsLoaded.getLoaded
            : 0,
        failure: null,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<InformationWatcherState> emit,
  ) {
    if (state.itemsLoaded + KDimensions.loadItems >
        state.informationModelItems.length) return;
    final filterItems = _filter(
      filtersIndex: state.filtersIndex,
      itemsLoaded: state.itemsLoaded + KDimensions.loadItems,
      informationModelItems: state.informationModelItems,
    );
    emit(
      state.copyWith(
        filteredInformationModelItems: filterItems,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded + KDimensions.loadItems
            : filterItems.length,
      ),
    );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<InformationWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filteredInformationModelItems: _filter(
          filtersIndex: null,
          itemsLoaded: state.itemsLoaded.getLoaded,
          informationModelItems: state.informationModelItems,
        ),
        filtersIndex: null,
      ),
    );
  }

  void _onFilter(
    _Filter event,
    Emitter<InformationWatcherState> emit,
  ) {
    final selectedFilters = List<int>.from(state.filtersIndex ?? []);

    state.filtersIndex?.contains(event.filterIndex) ?? false
        ? selectedFilters.remove(event.filterIndex)
        : selectedFilters.add(event.filterIndex);

    final filterItems = _filter(
      filtersIndex: selectedFilters,
      informationModelItems: state.informationModelItems,
      itemsLoaded: state.itemsLoaded.getLoaded,
    );

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loaded,
        filteredInformationModelItems: filterItems,
        filtersIndex: selectedFilters,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded.getLoaded
            : filterItems.length,
      ),
    );
  }

  List<InformationModel> _filter({
    required List<int>? filtersIndex,
    required int itemsLoaded,
    required List<InformationModel> informationModelItems,
  }) {
    if (informationModelItems.isEmpty) return [];
    final loadedItemsCount = itemsLoaded.clamp(0, informationModelItems.length);

    if (filtersIndex == null || filtersIndex.isEmpty) {
      return informationModelItems.take(loadedItemsCount).toList();
    }

    final filtersText = filtersIndex
        .map((index) => informationModelItems.overallTagsBloc.elementAt(index))
        .toList();

    return informationModelItems
        .where((item) => filtersText.every(item.category.contains))
        .take(loadedItemsCount)
        .toList();
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

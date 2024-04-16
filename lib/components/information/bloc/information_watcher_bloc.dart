import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
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
          const InformationWatcherState(
            informationModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredInformationModelItems: [],
            filter: null,
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
          filter: state.filter,
          itemsLoaded: state.itemsLoaded + 1,
          informationModelItems: event.informationItemsModel,
        ),
        filter: null,
        itemsLoaded: event.informationItemsModel.isNotEmpty ? 1 : 0,
        failure: null,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<InformationWatcherState> emit,
  ) {
    if (state.itemsLoaded + 1 > state.informationModelItems.length) return;
    final filterItems = _filter(
      filter: state.filter,
      itemsLoaded: state.itemsLoaded + 1,
      informationModelItems: state.informationModelItems,
    );
    emit(
      state.copyWith(
        filteredInformationModelItems: filterItems,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded + 1
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
          filter: null,
          itemsLoaded: state.itemsLoaded,
          informationModelItems: state.informationModelItems,
        ),
        filter: null,
      ),
    );
  }

  void _onFilter(
    _Filter event,
    Emitter<InformationWatcherState> emit,
  ) {
    final filterItems = _filter(
      filter: event.filter,
      informationModelItems: state.informationModelItems,
      itemsLoaded: state.itemsLoaded,
    );
    emit(
      state.copyWith(
        filteredInformationModelItems: filterItems,
        filter: event.filter,
        itemsLoaded: filterItems.length >= state.itemsLoaded
            ? state.itemsLoaded
            : filterItems.length,
      ),
    );
  }

  List<InformationModel> _filter({
    required String? filter,
    required int itemsLoaded,
    required List<InformationModel> informationModelItems,
  }) {
    if (itemsLoaded > informationModelItems.length) {
      itemsLoaded = informationModelItems.length;
    }
    if (filter != null) {
      final filterItems = informationModelItems
          .where(
            (element) => element.tags == null || element.tags!.contains(filter),
          )
          .toList();
      return filterItems.sublist(
        0,
        itemsLoaded > filterItems.length ? filterItems.length : itemsLoaded,
      );
    } else {
      return informationModelItems.sublist(
        0,
        itemsLoaded > informationModelItems.length
            ? informationModelItems.length
            : itemsLoaded,
      );
    }
  }

  void _onFailure(
    _Failure event,
    Emitter<InformationWatcherState> emit,
  ) {
    debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: const SomeFailure.serverError().toInformation(),
      ),
    );
  }

  @override
  Future<void> close() {
    _informationItemsSubscription?.cancel();
    return super.close();
  }
}

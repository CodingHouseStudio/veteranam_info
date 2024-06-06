import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'discount_watcher_event.dart';

part 'discount_watcher_state.dart';

part 'discount_watcher_bloc.freezed.dart';

@Injectable()
class DiscountWatcherBloc
    extends Bloc<DiscountWatcherEvent, DiscountWatcherState> {
  DiscountWatcherBloc({
    required IDiscountRepository discountRepository,
  })  : _discountRepository = discountRepository,
        super(
          const _Initial(
            discountModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredDiscountModelItems: [],
            filters: null,
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

  final IDiscountRepository _discountRepository;
  StreamSubscription<List<DiscountModel>>? _discountItemsSubscription;

  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    await _discountItemsSubscription?.cancel();
    _discountItemsSubscription = _discountRepository.getDiscountItems().listen(
      (discount) => add(
        DiscountWatcherEvent.updated(
          discount,
        ),
      ),
      onError: (dynamic error) {
        debugPrint('error is $error');
        add(DiscountWatcherEvent.failure(error));
      },
    );
  }

  // ignore: flutter_style_todos
  void _onUpdated(
    _Updated event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      DiscountWatcherState(
        discountModelItems: event.discountItemsModel,
        loadingStatus: LoadingStatus.loaded,
        filteredDiscountModelItems: event.discountItemsModel.isNotEmpty
            ? _filter(
                filters: state.filters,
                itemsLoaded: state.itemsLoaded != 0 ? state.itemsLoaded : 1,
                discountModelItems: event.discountItemsModel,
              )
            : [],
        filters: state.filters,
        itemsLoaded: event.discountItemsModel.isNotEmpty
            ? state.itemsLoaded != 0
                ? state.itemsLoaded
                : 1
            : 0,
        failure: null,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountWatcherState> emit,
  ) {
    if (state.itemsLoaded + 1 > state.discountModelItems.length) return;
    final filterItems = _filter(
      filters: state.filters,
      itemsLoaded: state.itemsLoaded + 1,
      discountModelItems: state.discountModelItems,
    );
    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded + 1
            : filterItems.length,
      ),
    );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filteredDiscountModelItems: _filter(
          filters: null,
          itemsLoaded: state.itemsLoaded,
          discountModelItems: state.discountModelItems,
        ),
        filters: null,
      ),
    );
  }

  void _onFilter(
    _Filter event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final selectedFilters = List<String>.from(state.filters ?? []);

    event.isSelected ?? false
        ? selectedFilters.add(event.filter!)
        : selectedFilters.remove(event.filter);

    final filterItems = _filter(
      filters: selectedFilters,
      discountModelItems: state.discountModelItems,
      itemsLoaded: state.itemsLoaded,
    );

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loaded,
        filteredDiscountModelItems: filterItems,
        filters: selectedFilters,
        itemsLoaded: filterItems.length >= state.itemsLoaded
            ? state.itemsLoaded
            : filterItems.length,
      ),
    );
  }

  List<DiscountModel> _filter({
    required List<String>? filters,
    required int itemsLoaded,
    required List<DiscountModel> discountModelItems,
  }) {
    final filteredItems = discountModelItems.where((element) {
      if (filters != null && filters.isNotEmpty) {
        return filters.any(element.category.contains);
      }
      return true;
    }).toList();

    final itemsToLoad =
        itemsLoaded > filteredItems.length ? filteredItems.length : itemsLoaded;

    return filteredItems.sublist(0, itemsToLoad);
  }

  void _onFailure(
    _Failure event,
    Emitter<DiscountWatcherState> emit,
  ) {
    debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: const SomeFailure.serverError().toDiscount(),
      ),
    );
  }

  @override
  Future<void> close() {
    _discountItemsSubscription?.cancel();
    return super.close();
  }
}

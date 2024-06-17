import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            filtersCategoriesIndex: null,
            itemsLoaded: 0,
            failure: null,
            filtersCitiesIndex: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterCity>(_onFilterCity);
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
                filtersIndex: state.filtersCategoriesIndex,
                itemsLoaded: state.itemsLoaded.getLoaded,
                discountModelItems: event.discountItemsModel,
              )
            : [],
        filtersCategoriesIndex: state.filtersCategoriesIndex,
        itemsLoaded: event.discountItemsModel.isNotEmpty
            ? state.itemsLoaded.getLoaded
            : 0,
        filtersCitiesIndex: state.filtersCategoriesIndex,
        failure: null,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountWatcherState> emit,
  ) {
    if (state.itemsLoaded + KDimensions.loadItems >
        state.discountModelItems.length) return;
    final filterItems = _filter(
      filtersIndex: state.filtersCategoriesIndex,
      itemsLoaded: state.itemsLoaded + KDimensions.loadItems,
      discountModelItems: state.discountModelItems,
    );
    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded + KDimensions.loadItems
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
          filtersIndex: null,
          itemsLoaded: state.itemsLoaded,
          discountModelItems: state.discountModelItems,
        ),
        filtersCategoriesIndex: null,
        filtersCitiesIndex: null,
      ),
    );
  }

  void _onFilterCategory(
    _FilterCategory event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters = List<int>.from(state.filtersCategoriesIndex ?? []);

    state.filtersCategoriesIndex?.contains(event.filterIndex) ?? false
        ? selectedFilters.remove(event.filterIndex)
        : selectedFilters.add(event.filterIndex);

    final filterItems = _filter(
      filtersIndex: selectedFilters,
      discountModelItems: state.discountModelItems,
      itemsLoaded: state.itemsLoaded.getLoaded,
    );

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loaded,
        filteredDiscountModelItems: filterItems,
        filtersCategoriesIndex: selectedFilters,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded.getLoaded
            : filterItems.length,
      ),
    );
  }

  void _onFilterCity(
    _FilterCity event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters = List<int>.from(state.filtersCategoriesIndex ?? []);

    state.filtersCategoriesIndex?.contains(event.filterIndex) ?? false
        ? selectedFilters.remove(event.filterIndex)
        : selectedFilters.add(event.filterIndex);

    final filterItems = _filter(
      filtersIndex: selectedFilters,
      discountModelItems: state.discountModelItems,
      itemsLoaded: state.itemsLoaded.getLoaded,
    );

    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loaded,
        filteredDiscountModelItems: filterItems,
        filtersCategoriesIndex: selectedFilters,
        itemsLoaded: filterItems.length > state.itemsLoaded
            ? state.itemsLoaded.getLoaded
            : filterItems.length,
      ),
    );
  }

  List<DiscountModel> _filter({
    required List<int>? filtersIndex,
    required int itemsLoaded,
    required List<DiscountModel> discountModelItems,
  }) {
    if (discountModelItems.isEmpty) return [];
    final loadedItemsCount = itemsLoaded.clamp(0, discountModelItems.length);

    if (filtersIndex == null || filtersIndex.isEmpty) {
      return discountModelItems.take(loadedItemsCount).toList();
    }

    final filtersText = filtersIndex
        .map((index) => discountModelItems.overallTagsBloc.elementAt(index))
        .toList();

    return discountModelItems
        .where((item) => filtersText.every(item.category.contains))
        .take(loadedItemsCount)
        .toList();
  }

  void _onFailure(
    _Failure event,
    Emitter<DiscountWatcherState> emit,
  ) {
    debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: DiscountFailure.error,
      ),
    );
  }

  @override
  Future<void> close() {
    _discountItemsSubscription?.cancel();
    return super.close();
  }
}

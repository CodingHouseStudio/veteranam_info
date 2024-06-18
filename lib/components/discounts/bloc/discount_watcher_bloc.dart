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
            freeFilter: false,
            reverse: false,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterCity>(_onFilterCity);
    on<_FilterReset>(_onFilterReset);
    on<_ReverseFilter>(_onReverseFilter);
    on<_isFreeFilter>(_onIsFreeFilter);
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
        filteredDiscountModelItems: _filter(
          categoryIndex: state.filtersCategoriesIndex,
          itemsLoaded: state.itemsLoaded,
          cityIndex: state.filtersCitiesIndex,
          list: event.discountItemsModel,
        ),
        filtersCategoriesIndex: state.filtersCategoriesIndex,
        itemsLoaded:
            state.itemsLoaded.getLoaded(list: event.discountItemsModel),
        failure: null,
        filtersCitiesIndex: state.filtersCitiesIndex,
        freeFilter: state.freeFilter,
        reverse: false,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountWatcherState> emit,
  ) {
    if (state.itemsLoaded.checkLoadingPosible(state.discountModelItems)) return;
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final filterItems = _filter(
      categoryIndex: state.filtersCategoriesIndex,
      itemsLoaded: state.itemsLoaded + KDimensions.loadItems,
      cityIndex: state.filtersCitiesIndex,
    );
    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        itemsLoaded: (state.itemsLoaded + KDimensions.loadItems)
            .getLoaded(list: filterItems),
        loadingStatus: LoadingStatus.loaded,
      ),
    );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filteredDiscountModelItems: state.discountModelItems.loading(
          itemsLoaded: state.itemsLoaded,
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
    final selectedFilters =
        state.filtersCategoriesIndex.filterIndex(event.filterIndex);

    final filterItems = _filter(
      categoryIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
      cityIndex: state.filtersCitiesIndex,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        filtersCategoriesIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: filterItems),
      ),
    );
  }

  void _onFilterCity(
    _FilterCity event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters =
        state.filtersCitiesIndex.filterIndex(event.filterIndex);

    final filterItems = _filter(
      cityIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
      categoryIndex: state.filtersCategoriesIndex,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        filtersCitiesIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: filterItems),
      ),
    );
  }

  void _onReverseFilter(
    _ReverseFilter event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final discountModelItems = state.discountModelItems.reversed.toList();

    final filterItems = _filter(
      cityIndex: state.filtersCitiesIndex,
      itemsLoaded: state.itemsLoaded,
      categoryIndex: state.filtersCategoriesIndex,
      list: discountModelItems,
    );

    emit(
      state.copyWith(
        discountModelItems: discountModelItems,
        filteredDiscountModelItems: filterItems,
        reverse: !state.reverse,
      ),
    );
  }

  void _onIsFreeFilter(
    _isFreeFilter event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final filterItems = _filter(
      cityIndex: state.filtersCitiesIndex,
      itemsLoaded: state.itemsLoaded,
      categoryIndex: state.filtersCategoriesIndex,
      freeFilter: !state.freeFilter,
    );

    emit(
      state.copyWith(
        freeFilter: !state.freeFilter,
        filteredDiscountModelItems: filterItems,
      ),
    );
  }

  List<DiscountModel> _filter({
    required List<int>? categoryIndex,
    required List<int>? cityIndex,
    required int itemsLoaded,
    bool? freeFilter,
    List<DiscountModel>? list,
  }) {
    final listValue = (list ?? state.discountModelItems)
        .loadingFilter(
          filtersIndex: categoryIndex,
          itemsLoaded: itemsLoaded,
          getFilter: (item) => item.category,
        )
        .loadingFilter(
          filtersIndex: cityIndex,
          itemsLoaded: itemsLoaded,
          getFilter: (item) => [
            if (item.location != null) ...item.location!,
            if (item.subLocation != null) item.subLocation.toString(),
          ],
          fullList: state.discountModelItems,
        );
    if (freeFilter ?? state.freeFilter) {
      return listValue
          .where(
            (element) => element.discount.contains(100),
          )
          .toList();
    } else {
      return listValue;
    }
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

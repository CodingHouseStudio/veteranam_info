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
            filtersLocationIndex: null,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterLocation>(_onFilterLocation);
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
        filteredDiscountModelItems: _filter(
          categoryIndex: state.filtersCategoriesIndex,
          itemsLoaded: state.itemsLoaded,
          locationIndex: state.filtersLocationIndex,
          list: event.discountItemsModel,
        ),
        filtersCategoriesIndex: state.filtersCategoriesIndex,
        itemsLoaded:
            state.itemsLoaded.getLoaded(list: event.discountItemsModel),
        failure: null,
        filtersLocationIndex: state.filtersLocationIndex,
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
      locationIndex: state.filtersLocationIndex,
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
        filtersLocationIndex: null,
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
      locationIndex: state.filtersLocationIndex,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        filtersCategoriesIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: filterItems),
      ),
    );
  }

  void _onFilterLocation(
    _FilterLocation event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters =
        state.filtersLocationIndex.filterIndex(event.filterIndex);

    final filterItems = _filter(
      locationIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
      categoryIndex: state.filtersCategoriesIndex,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        filtersLocationIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: filterItems),
      ),
    );
  }

  List<DiscountModel> _filter({
    required List<int>? categoryIndex,
    required List<int>? locationIndex,
    required int itemsLoaded,
    List<DiscountModel>? list,
  }) {
    final filteredList = (list ?? state.discountModelItems)
        .loadingFilter(
          filtersIndex: categoryIndex,
          itemsLoaded: null,
          getFilter: (item) => item.category,
        )
        .loadingFilter(
          filtersIndex: locationIndex
              ?.where((element) => element != 0 && element != 1)
              .toList(),
          itemsLoaded: itemsLoaded,
          getFilter: (item) => [
            if (item.location != null) ...item.location!,
            if (item.subLocation != null) ...item.subLocation._getList,
          ],
          overallFilter: (list ?? state.discountModelItems)._getLocationItems,
        );

    return (locationIndex != null
            ? (locationIndex.contains(0) ? filteredList.reversed : filteredList)
                .where(
                (element) =>
                    !locationIndex.contains(1) ||
                    element.discount.contains(100),
              )
            : filteredList)
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

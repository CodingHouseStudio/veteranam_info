import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'discount_watcher_bloc.freezed.dart';
part 'discount_watcher_event.dart';
part 'discount_watcher_state.dart';

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
            filtersCategoriesIndex: [],
            itemsLoaded: 0,
            failure: null,
            filtersLocationIndex: [],
            reportItems: [],
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterLocation>(_onFilterLocation);
    on<_FilterReset>(_onFilterReset);
    on<_Report>(_onReport);
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
        // debugPrint('error is $error');
        add(DiscountWatcherEvent.failure(error));
      },
    );
  }

  void _onUpdated(
    _Updated event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      _Initial(
        discountModelItems: event.discountItemsModel,
        loadingStatus: LoadingStatus.loaded,
        filteredDiscountModelItems: _filter(
          categoryIndex: state.filtersCategoriesIndex,
          itemsLoaded: KDimensions.loadItems,
          locationIndex: state.filtersLocationIndex,
          list: event.discountItemsModel,
        ),
        filtersCategoriesIndex: state.filtersCategoriesIndex,
        itemsLoaded:
            state.itemsLoaded.getLoaded(list: event.discountItemsModel),
        failure: null,
        filtersLocationIndex: state.filtersLocationIndex,
        reportItems: state.reportItems,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountWatcherState> emit,
  ) {
    if (state.itemsLoaded.checkLoadingPosible(state.discountModelItems)) {
      emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
      return;
    }
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
        loadingStatus: filterItems.isLoading(state.filteredDiscountModelItems),
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
        filtersCategoriesIndex: [],
        filtersLocationIndex: [],
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
        loadingStatus:
            filterItems.isLoadingFilter(state.filteredDiscountModelItems),
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
        loadingStatus:
            filterItems.isLoadingFilter(state.filteredDiscountModelItems),
      ),
    );
  }

  List<DiscountModel> _filter({
    required List<int>? categoryIndex,
    required List<int>? locationIndex,
    required int itemsLoaded,
    List<DiscountModel>? list,
    List<int>? reportItems,
  }) {
    final items = list ?? state.discountModelItems;
    final reportItemsValue = reportItems ?? state.reportItems;

    // Combine location filtering logic
    final locationFiltered = items
        .where(
          (item) =>
              locationIndex == null ||
              !locationIndex.contains(1) ||
              item.discount.contains(100),
        )
        .toList()
        .filterIndexs(reportItemsValue);

    // Optimized sorting with null-aware conversion
    final sortedItems = locationFiltered
      ..sort((a, b) {
        if (locationIndex != null && locationIndex.contains(0)) {
          final maxDiscountA =
              a.discount.isNotEmpty == true ? a.discount.reduce(max) : 0;
          final maxDiscountB =
              b.discount.isNotEmpty == true ? b.discount.reduce(max) : 0;

          if (maxDiscountA != maxDiscountB) {
            return maxDiscountB.compareTo(maxDiscountA); // Descending order
          }
        }

        final dateComparison = b.dateVerified.compareTo(a.dateVerified);
        if (dateComparison == 0) {
          // Attempt int conversion using null-aware operators
          final idA = int.tryParse(a.id);
          final idB = int.tryParse(b.id);

          if (idA != null && idB != null) {
            return idB.compareTo(idA); // Descending order
          } else {
            return 1;
          }
        }
        return dateComparison;
      });

    // Apply category and location filtering (chained)
    return sortedItems
        .loadingFilter(
          filtersIndex: categoryIndex,
          itemsLoaded: null,
          getFilter: (item) => item.category,
          fullList: items,
        )
        .loadingFilter(
          filtersIndex: locationIndex?.where((element) => element > 1).toList(),
          itemsLoaded: itemsLoaded,
          getFilter: (item) =>
              item.location?.toList() ?? item.subLocation?._getList ?? const [],
          overallFilter: items._getLocationItems,
        );
  }

  void _onReport(
    _Report event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        reportItems: state.reportItems
          ..add(state.discountModelItems.indexOf(event.discountModel)),
        filteredDiscountModelItems: _filter(
          categoryIndex: state.filtersCategoriesIndex,
          locationIndex: state.filtersLocationIndex,
          itemsLoaded: state.itemsLoaded,
        ),
      ),
    );
  }

  void _onFailure(
    _Failure event,
    Emitter<DiscountWatcherState> emit,
  ) {
    // debugPrint('error is ${event.failure}');
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

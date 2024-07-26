import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
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
    required IReportRepository reportRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _reportRepository = reportRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const _Initial(
            discountModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredDiscountModelItems: [],
            filtersCategoriesIndex: [],
            itemsLoaded: 0,
            failure: null,
            filtersLocationIndex: [],
            // reportItems: [],
            categoryDiscountModelItems: [],
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterLocation>(_onFilterLocation);
    on<_FilterReset>(_onFilterReset);
    // on<_GetReport>(_onGetReport);
  }

  final IDiscountRepository _discountRepository;
  StreamSubscription<List<DiscountModel>>? _discountItemsSubscription;
  final IReportRepository _reportRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    debugPrint('start date: ${DateTime.now()}');
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final reportItems = await _getReport();

    await _discountItemsSubscription?.cancel();
    _discountItemsSubscription = _discountRepository
        .getDiscountItems(
      reportIdItems: reportItems?.getIdCard,
    )
        .listen(
      (discount) {
        add(
          DiscountWatcherEvent.updated(
            discount,
          ),
        );
      },
      onError: (dynamic error) {
        // debugPrint('error is $error');
        add(DiscountWatcherEvent.failure(error));
      },
    );
  }

  Future<void> _onUpdated(
    _Updated event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    // final items = event.discountItemsModel.removeReportItems(
    //   checkFunction: (item) => item.id,
    //   reportItems: event.reportItems,
    // );
    // ..sort(
    //     (a, b) {
    //       final dateComparison = b.dateVerified.compareTo(a.dateVerified);
    //       if (dateComparison == 0) {
    //         // Attempt int conversion using null-aware operators
    //         final idA = int.tryParse(a.id);
    //         final idB = int.tryParse(b.id);

    //         if (idA != null && idB != null) {
    //           return idB.compareTo(idA); // Descending order
    //         } else {
    //           return 1;
    //         }
    //       }
    //       return dateComparison;
    //     },
    //   );
    debugPrint('without filter finish date: ${DateTime.now()}');
    final categoryFilter = _filterCategory(
      categoryIndex: state.filtersCategoriesIndex,
      list: event.discountItemsModel,
    );
    final (:list, :loadingStatus) = _filterLocation(
      itemsLoaded: KDimensions.loadItems,
      locationIndex: state.filtersLocationIndex,
      list: categoryFilter,
    );
    debugPrint('finish date: ${DateTime.now()}');
    emit(
      _Initial(
        discountModelItems: event.discountItemsModel,
        loadingStatus: loadingStatus,
        filteredDiscountModelItems: list,
        filtersCategoriesIndex: state.filtersCategoriesIndex,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        failure: null,
        filtersLocationIndex: state.filtersLocationIndex,
        // reportItems: event.reportItems,
        categoryDiscountModelItems: categoryFilter,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountWatcherState> emit,
  ) {
    if (state.itemsLoaded
        .checkLoadingPosible(state.categoryDiscountModelItems)) {
      emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
      return;
    }
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final (:list, :loadingStatus) = _filterLocation(
      itemsLoaded: state.itemsLoaded,
      locationIndex: state.filtersLocationIndex,
      loadItems: KDimensions.loadItems,
    );
    emit(
      state.copyWith(
        filteredDiscountModelItems: list,
        itemsLoaded:
            (state.itemsLoaded + KDimensions.loadItems).getLoaded(list: list),
        loadingStatus: loadingStatus,
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
        categoryDiscountModelItems: state.discountModelItems,
        filtersCategoriesIndex: [],
        filtersLocationIndex: [],
        loadingStatus: LoadingStatus.loaded,
      ),
    );
  }

  void _onFilterCategory(
    _FilterCategory event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters =
        state.filtersCategoriesIndex.changeListValue(event.filterIndex);

    final categoryItems = _filterCategory(
      categoryIndex: selectedFilters,
    );

    final (:list, :loadingStatus) = _filterLocation(
      itemsLoaded: state.itemsLoaded,
      locationIndex: state.filtersLocationIndex,
      list: categoryItems,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: list,
        filtersCategoriesIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        loadingStatus: loadingStatus,
        categoryDiscountModelItems: categoryItems,
      ),
    );
  }

  void _onFilterLocation(
    _FilterLocation event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters = state.filtersLocationIndex.checkValue(
      filterIndex: event.filterIndex,
      equalNumber: 2,
      largerNumber: 3,
    );

    final (:list, :loadingStatus) = _filterLocation(
      locationIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: list,
        filtersLocationIndex: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        loadingStatus: loadingStatus,
      ),
    );
  }

  ({List<DiscountModel> list, LoadingStatus loadingStatus}) _filterLocation({
    required List<int>? locationIndex,
    required int itemsLoaded,
    List<DiscountModel>? list,
    int? loadItems,
  }) {
    final items = list ?? state.categoryDiscountModelItems;

    // Combine location filtering logic
    final locationFiltered = items
        .where(
          (item) =>
              locationIndex == null ||
              !locationIndex.contains(1) ||
              item.discount.contains(100),
        )
        .toList();

    // Optimized sorting with null-aware conversion

    final sortedItems =
        _sorting(list: locationFiltered, locationIndex: locationIndex);

    // Apply category and location filtering (chained)
    return sortedItems.loadingFilterAndStatus(
      filtersIndex: locationIndex?.where((element) => element > 1).toList(),
      itemsLoaded: itemsLoaded,
      getFilter: (item) => [
        if (item.location != null) ...item.location!,
        if (item.subLocation != null) ...item.subLocation._getList,
      ],
      overallFilter: items._getLocationItems,
      loadItems: loadItems,
      containAnyItems: false,
    );
  }

  List<DiscountModel> _sorting({
    required List<DiscountModel> list,
    required List<int>? locationIndex,
  }) {
    if (locationIndex != null && locationIndex.contains(0)) {
      return list
        ..sort((a, b) {
          // if (locationIndex != null && locationIndex.contains(0)) {
          final maxDiscountA =
              a.discount.isNotEmpty == true ? a.discount.reduce(max) : 0;
          final maxDiscountB =
              b.discount.isNotEmpty == true ? b.discount.reduce(max) : 0;

          return maxDiscountB.compareTo(maxDiscountA); // Descending order

          // }
        });
    } else {
      return list;
    }
  }

  List<DiscountModel> _filterCategory({
    required List<int>? categoryIndex,
    List<DiscountModel>? list,
  }) =>
      (list ?? state.discountModelItems).loadingFilter(
        filtersIndex: categoryIndex,
        itemsLoaded: null,
        getFilter: (item) => item.category,
      );

  // Future<void> _onGetReport(
  //   _GetReport event,
  //   Emitter<DiscountWatcherState> emit,
  // ) async {
  //   // Get report items and remove them from existing items
  //   final reportItems = await _getReport();
  //   final items = state.discountModelItems.removeReportItems(
  //     checkFunction: (item) => item.id,
  //     reportItems: reportItems,
  //   );

  //   final filtersCategoriesIndex = items.updateFilterList(
  //     getFilter: (item) => item.category,
  //     previousList: state.discountModelItems,
  //     previousFilter: state.filtersCategoriesIndex,
  //   );
  //   final filtersLocationIndex = items.updateFilterList(
  //     getFilter: (item) =>
  //         item.location?.toList() ?? item.subLocation?._getList ?? const [],
  //     previousList: state.discountModelItems,
  //     previousFilter: state.filtersLocationIndex,
  //   );
  //   final categoryItems = _filterCategory(
  //     categoryIndex: filtersCategoriesIndex,
  //     list: items,
  //   );
  //   final (:list, :loadingStatus) = _filterLocation(
  //     locationIndex: filtersLocationIndex,
  //     itemsLoaded: state.itemsLoaded,
  //     list: categoryItems,
  //   );
  //   emit(
  //     state.copyWith(
  //       discountModelItems: items,
  //       // reportItems: reportItems,
  //       filteredDiscountModelItems: list,
  //       loadingStatus: loadingStatus,
  //       filtersCategoriesIndex: filtersCategoriesIndex,
  //       filtersLocationIndex: filtersLocationIndex,
  //       categoryDiscountModelItems: categoryItems,
  //     ),
  //   );
  // }

  Future<List<ReportModel>?> _getReport() async {
    final reportItems = await _reportRepository.getCardReportById(
      cardEnum: CardEnum.discount,
      userId: _appAuthenticationRepository.currentUser.id,
    );
    return reportItems.fold(
      (l) => null,
      (r) => r.isEmpty ? null : r,
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

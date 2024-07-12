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
    required IReportRepository reportRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _reportRepository = reportRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(
          const DiscountWatcherState(
            discountModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredDiscountModelItems: [],
            filtersCategoriesIndex: [],
            itemsLoaded: 0,
            failure: null,
            filtersLocationIndex: [],
            reportItems: [],
            filtersSubcategoriesIndex: [],
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterLocation>(_onFilterLocation);
    on<_FilterSubcategory>(_onFilterSubcategory);
    on<_FilterReset>(_onFilterReset);
    on<_GetReport>(_onGetReport);
  }

  final IDiscountRepository _discountRepository;
  StreamSubscription<List<DiscountModel>>? _discountItemsSubscription;
  final IReportRepository _reportRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final reportItems = await _getReport();

    await _discountItemsSubscription?.cancel();
    _discountItemsSubscription = _discountRepository.getDiscountItems().listen(
      (discount) => add(
        DiscountWatcherEvent.updated(
          discountItemsModel: discount,
          reportItems: reportItems,
        ),
      ),
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
    final list = event.discountItemsModel.removeReportItems(
      checkFunction: (item) => item.id,
      reportItems: event.reportItems,
    );
    emit(
      DiscountWatcherState(
        discountModelItems: list,
        loadingStatus: LoadingStatus.loaded,
        filteredDiscountModelItems: _filter(
          categoryIndex: state.filtersCategoriesIndex,
          itemsLoaded: KDimensions.loadItems,
          locationIndex: state.filtersLocationIndex,
          list: list,
          subcategoriesIndex: state.filtersSubcategoriesIndex,
        ),
        filtersCategoriesIndex: state.filtersCategoriesIndex,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        failure: null,
        filtersLocationIndex: state.filtersLocationIndex,
        reportItems: event.reportItems,
        filtersSubcategoriesIndex: state.filtersSubcategoriesIndex,
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
      itemsLoaded: state.itemsLoaded,
      locationIndex: state.filtersLocationIndex,
      loadItems: KDimensions.loadItems,
      subcategoriesIndex: state.filtersSubcategoriesIndex,
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
        filtersSubcategoriesIndex: [],
      ),
    );
  }

  void _onFilterCategory(
    _FilterCategory event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters =
        state.filtersCategoriesIndex.changeListValue(event.filterIndex);

    final filterItems = _filter(
      categoryIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
      locationIndex: state.filtersLocationIndex,
      subcategoriesIndex: state.filtersSubcategoriesIndex,
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

  void _onFilterSubcategory(
    _FilterSubcategory event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters =
        state.filtersSubcategoriesIndex.changeListValue(event.filterIndex);

    final filterItems = _filter(
      categoryIndex: state.filtersCategoriesIndex,
      itemsLoaded: state.itemsLoaded,
      locationIndex: state.filtersLocationIndex,
      subcategoriesIndex: selectedFilters,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: filterItems,
        filtersSubcategoriesIndex: selectedFilters,
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
        state.filtersLocationIndex.changeListValue(event.filterIndex);

    final filterItems = _filter(
      locationIndex: selectedFilters,
      itemsLoaded: state.itemsLoaded,
      categoryIndex: state.filtersCategoriesIndex,
      subcategoriesIndex: state.filtersSubcategoriesIndex,
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
    required List<int>? subcategoriesIndex,
    required List<int>? locationIndex,
    required int itemsLoaded,
    List<DiscountModel>? list,
    int? loadItems,
  }) {
    final items = list ?? state.discountModelItems;

    // Combine location filtering logic
    // final locationFiltered = items
    //     .where(
    //       (item) =>
    //           locationIndex == null ||
    //           !locationIndex.contains(1) ||
    //           item.discount.contains(100),
    //     )
    //     .toList();

    // Optimized sorting with null-aware conversion
    // final sortedItems = items
    //   ..sort((a, b) {
    //     // if (locationIndex != null && locationIndex.contains(0)) {
    //     //   final maxDiscountA =
    //     //       a.discount.isNotEmpty == true ? a.discount.reduce(max) : 0;
    //     //   final maxDiscountB =
    //     //       b.discount.isNotEmpty == true ? b.discount.reduce(max) : 0;

    //     //   if (maxDiscountA != maxDiscountB) {
    //     //     return maxDiscountB.compareTo(maxDiscountA); // Descending order
    //     //   }
    //     // }

    //     final dateComparison = b.dateVerified.compareTo(a.dateVerified);
    //     if (dateComparison == 0) {
    //       // Attempt int conversion using null-aware operators
    //       final idA = int.tryParse(a.id);
    //       final idB = int.tryParse(b.id);

    //       if (idA != null && idB != null) {
    //         return idB.compareTo(idA); // Descending order
    //       } else {
    //         return 1;
    //       }
    //     }
    //     return dateComparison;
    //   });

    // Apply category and location filtering (chained)
    return items
        .loadingFilter(
          filtersIndex: categoryIndex,
          itemsLoaded: null,
          getFilter: (item) => item.category,
          fullList: items,
        )
        .loadingFilter(
          filtersIndex: subcategoriesIndex,
          itemsLoaded: null,
          getFilter: (item) => item.subcategory,
          fullList: items,
        )
        .loadingFilter(
          filtersIndex: locationIndex,
          itemsLoaded: itemsLoaded,
          getFilter: (item) => [
            if (item.location != null) ...item.location!,
            if (item.subLocation != null) ...item.subLocation!._getList,
          ],
          overallFilter: items._getLocationItems,
          loadItems: loadItems,
        );
  }

  Future<void> _onGetReport(
    _GetReport event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    // Get report items and remove them from existing items
    final reportItems = await _getReport();
    final list = state.discountModelItems.removeReportItems(
      checkFunction: (item) => item.id,
      reportItems: reportItems,
    );

    final filtersCategoriesIndex = list.updateFilterList(
      getFilter: (item) => item.category,
      previousList: state.discountModelItems,
      previousFilter: state.filtersCategoriesIndex,
    );
    final filtersLocationIndex = list.updateFilterList(
      getFilter: (item) =>
          item.location?.toList() ?? item.subLocation?._getList ?? const [],
      previousList: state.discountModelItems,
      previousFilter: state.filtersLocationIndex,
    );
    final filterItems = _filter(
      categoryIndex: filtersCategoriesIndex,
      locationIndex: filtersLocationIndex,
      itemsLoaded: state.itemsLoaded,
      list: list,
      subcategoriesIndex: state.filtersSubcategoriesIndex,
    );
    emit(
      state.copyWith(
        discountModelItems: list,
        reportItems: reportItems,
        filteredDiscountModelItems: filterItems,
        loadingStatus: LoadingStatus.loaded,
        filtersCategoriesIndex: filtersCategoriesIndex,
        filtersLocationIndex: filtersLocationIndex,
      ),
    );
  }

  Future<List<ReportModel>> _getReport() async {
    final reportItems = await _reportRepository.getCardReportById(
      cardEnum: CardEnum.discount,
      userId: _appAuthenticationRepository.currentUser.id,
    );
    return reportItems.fold(
      (l) => [],
      (r) => r,
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

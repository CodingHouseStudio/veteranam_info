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
            filtersCategories: [],
            itemsLoaded: 0,
            failure: null,
            filtersLocation: [],
            // reportItems: [],
            categoryDiscountModelItems: [], locationDiscountModelItems: [],
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterLocation>(_onFilterLocation);
    on<_FilterLocations>(_onFilterLocations);
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
    if (event.discountItemsModel.isEmpty && Config.isProduction) return;
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
    final categoryFilter = _filterCategory(
      categories: state.filtersCategories,
      list: event.discountItemsModel,
    );
    final locationList = _filterLocation(
      location: state.filtersLocation,
      listValue: event.discountItemsModel,
      // categiryList: categoryFilter,
    );
    final (:list, :loadingStatus) = _filter(
      categoryList: categoryFilter,
      locationList: locationList,
      itemsLoaded: state.itemsLoaded,
    );
    emit(
      _Initial(
        discountModelItems: event.discountItemsModel,
        loadingStatus: loadingStatus,
        filteredDiscountModelItems: list,
        filtersCategories: state.filtersCategories,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        failure: null,
        filtersLocation: state.filtersLocation,
        // reportItems: event.reportItems,
        categoryDiscountModelItems: categoryFilter,
        locationDiscountModelItems: locationList,
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
    // final (:list, :loadingStatus) = _filterLocation(
    //   itemsLoaded: state.itemsLoaded,
    //   locationIndex: state.filtersLocationIndex,
    //   loadItems: KDimensions.loadItems,
    // );
    final (:list, :loadingStatus) = _filter(
      categoryList: state.categoryDiscountModelItems,
      locationList: state.locationDiscountModelItems,
      itemsLoaded: state.itemsLoaded,
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
        locationDiscountModelItems: state.discountModelItems,
        filtersCategories: [],
        filtersLocation: [],
        loadingStatus: LoadingStatus.loaded,
      ),
    );
  }

  void _onFilterCategory(
    _FilterCategory event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters = state.filtersCategories.changeListValue(
      eventFilter: event.value,
      removeValue: CategoryEnum.all,
    );

    final categoryItems = _filterCategory(
      categories: selectedFilters,
    );
    final (:list, :loadingStatus) = _filter(
      categoryList: categoryItems,
      locationList: state.locationDiscountModelItems,
      itemsLoaded: state.itemsLoaded,
    );

    // final (:list, :loadingStatus) = _filterLocation(
    //   itemsLoaded: state.itemsLoaded,
    //   locationIndex: state.filtersLocationIndex,
    //   modelList: categoryItems,
    // );

    emit(
      state.copyWith(
        filteredDiscountModelItems: list,
        filtersCategories: selectedFilters,
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
    final selectedFilters = state.filtersLocation.checkValue(
      filterValue: event.value,
      equalValue: SubLocation.allStoresOfChain,
    );

    _filterLocations(emit: emit, selectedFilters: selectedFilters);
  }

  void _onFilterLocations(
    _FilterLocations event,
    Emitter<DiscountWatcherState> emit,
  ) {
    _filterLocations(emit: emit, selectedFilters: event.filterList);
  }

  void _filterLocations({
    required Emitter<DiscountWatcherState> emit,
    required List<dynamic> selectedFilters,
  }) {
    final locationList = _filterLocation(
      location: selectedFilters,
    );
    final (:list, :loadingStatus) = _filter(
      categoryList: state.categoryDiscountModelItems,
      locationList: locationList,
      itemsLoaded: state.itemsLoaded,
      location: selectedFilters,
    );

    emit(
      state.copyWith(
        filteredDiscountModelItems: list,
        locationDiscountModelItems: locationList,
        filtersLocation: selectedFilters,
        itemsLoaded: state.itemsLoaded.getLoaded(list: list),
        loadingStatus: loadingStatus,
      ),
    );
  }

  List<DiscountModel> _filterLocation({
    required List<dynamic>? location,
    List<DiscountModel>? listValue,
    // List<DiscountModel>? categiryList,
  }) {
    final items = listValue ??
        state.discountModelItems
            .where(
              (item) =>
                  location == null ||
                  !location.contains(DiscountEnum.free) ||
                  item.discount.contains(100),
            )
            .toList();
    final list = items.loadingFilter(
      filtersValue:
          location?.where((element) => element is! DiscountEnum).toList(),
      itemsLoaded: null,
      getENFilter: (item) => [
        if (item.location != null) ...item.location!,
        if (item.subLocation != null) ...item.subLocation!._getList,
      ],
      // overallFilter: items
      //     ._getLocationItems(categiryList ?? state
      // .categoryDiscountModelItems),
      // containAnyItems: false,
    );
    return list;
  }

  List<DiscountModel> _sorting({
    required List<DiscountModel> list,
    required List<dynamic>? location,
  }) {
    final value = location ?? state.filtersLocation;
    if (value.contains(DiscountEnum.largestSmallest)) {
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
    required List<dynamic>? categories,
    List<DiscountModel>? list,
    // List<DiscountModel>? locationList,
  }) =>
      (list ?? state.discountModelItems).loadingFilter(
        filtersValue: categories,
        itemsLoaded: null,
        getENFilter: (item) => item.category,
        // listForFilter: locationList ?? state.locationDiscountModelItems,
      );

  ({List<DiscountModel> list, LoadingStatus loadingStatus}) _filter({
    required List<DiscountModel> categoryList,
    required List<DiscountModel> locationList,
    required int itemsLoaded,
    int? loadItems,
    List<dynamic>? location,
  }) {
    final (:list, :loadingStatus) = categoryList.combiningFilteredLists(
      secondList: locationList,
      itemsLoaded: itemsLoaded,
      loadItems: loadItems,
      sorting: (list) => _sorting(list: list, location: location),
    );
    return (list: list, loadingStatus: loadingStatus);
  }

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

import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discount_watcher_bloc.freezed.dart';
part 'discount_watcher_event.dart';
part 'discount_watcher_state.dart';

@Injectable(env: [Config.user])
class DiscountWatcherBloc
    extends Bloc<DiscountWatcherEvent, DiscountWatcherState> {
  DiscountWatcherBloc({
    required IDiscountRepository discountRepository,
    // required IReportRepository reportRepository,
    // required IAppAuthenticationRepository appAuthenticationRepository,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
  })  : _discountRepository = discountRepository,
        // _reportRepository = reportRepository,
        // _appAuthenticationRepository = appAuthenticationRepository,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        super(
          const _Initial(
            discountModelItems: [],
            loadingStatus: LoadingStatus.initial,
            filteredDiscountModelItems: [],
            // filtersCategories: [],
            itemsLoaded: 0,
            failure: null,
            filterLocation: [],
            // reportItems: [],
            categoryDiscountModelItems: [], locationDiscountModelItems: [],
            sortingDiscountModelItems: [], sorting: [], filterCategory: [],
            categoryListEmpty: true,
            choosenLocationList: [],
            choosenSortingnList: [],
            isEnglish: false,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterLocation>(_onFilterLocation);
    on<_SetMobFilter>(_setMobFilter);
    on<_FilterReset>(_onFilterReset);
    on<_Sorting>(_onSorting);
    // on<_GetReport>(_onGetReport);
  }

  final IDiscountRepository _discountRepository;
  StreamSubscription<List<DiscountModel>>? _discountItemsSubscription;
  // final IReportRepository _reportRepository;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;

  @visibleForTesting
  static const loadingItemsKey = DiscountConfigCubit.loadingItemsKey;

  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    // final reportItems = await _getReport();

    await _discountItemsSubscription?.cancel();
    _discountItemsSubscription = _discountRepository
        .getDiscountItems(
            // reportIdItems: reportItems?.getIdCard,
            )
        .listen(
      (discount) {
        add(
          DiscountWatcherEvent.updated(
            discountItemsModel: discount,
            isEnglish: event.isEnglish,
          ),
        );
      },
      onError: (dynamic error, StackTrace stack) {
        add(DiscountWatcherEvent.failure(error: error, stack: stack));
      },
    );
  }

  Future<void> _onUpdated(
    _Updated event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    if (event.discountItemsModel.isEmpty && Config.isProduction) {
      return;
    }

    final sortingList = _sorting(list: event.discountItemsModel, sorting: null);

    final categoryFilter = _filterCategory(
      categories: state.filterCategory,
      list: sortingList,
    );
    final locationes = categoryFilter
        .getLocationFilter(isEnglish: event.isEnglish)
        .map(
          (e) => state.choosenLocationList.contains(e)
              ? e.copyWith(isSelected: true)
              : e,
        )
        .toList();

    final locationList = _filterLocation(
      location: state.filterLocation,
      listValue: sortingList,
    );

    final categories = locationList
        .overallItems(
          isEnglish: event.isEnglish,
          getFilter: (item) => item.category,
          calculateNumber: true,
        )
        .map(
          (e) => state.filterCategory
                      .where((element) => element == e)
                      .firstOrNull
                      ?.isSelected ??
                  false
              ? e.copyWith(isSelected: true)
              : e,
        )
        .toList();

    final (:list, :loadingStatus) = _filter(
      categoryList: categoryFilter,
      locationList: locationList,
      itemsLoaded: state.itemsLoaded.getLoaded(
        list: event.discountItemsModel,
        loadItems: getItemsLoading,
      ),
    );

    // Before emitting state
    emit(
      _Initial(
        discountModelItems: event.discountItemsModel,
        loadingStatus: loadingStatus,
        filteredDiscountModelItems: list,
        filterCategory: categories,
        itemsLoaded: list.length,
        isEnglish: event.isEnglish,
        categoryListEmpty: state.categoryListEmpty,
        failure: null,
        filterLocation: locationes,
        categoryDiscountModelItems: categoryFilter,
        locationDiscountModelItems: locationList,
        sorting: [
          SortingItem(
            DiscountEnum.free,
            isSelected: state.sorting.firstOrNull?.isSelected ?? false,
          ),
          SortingItem(
            DiscountEnum.largestSmallest,
            isSelected: state.sorting.lastOrNull?.isSelected ?? false,
          ),
        ],
        sortingDiscountModelItems: sortingList,
        choosenLocationList: state.choosenLocationList,
        choosenSortingnList: [],
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
    // emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    // final (:list, :loadingStatus) = _filterLocation(
    //   itemsLoaded: state.itemsLoaded,
    //   locationIndex: state.filtersLocationIndex,
    //   loadItems: getItemsLoading,
    // );
    final (:list, :loadingStatus) = _filter(
      categoryList: state.categoryDiscountModelItems,
      locationList: state.locationDiscountModelItems,
      itemsLoaded: state.itemsLoaded,
      loadItems: getItemsLoading,
    );
    emit(
      state.copyWith(
        filteredDiscountModelItems: list,
        itemsLoaded: list.length,
        loadingStatus: loadingStatus,
      ),
    );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final locationes =
        state.discountModelItems.getLocationFilter(isEnglish: state.isEnglish);

    final categories = state.discountModelItems.overallItems(
      isEnglish: state.isEnglish,
      getFilter: (item) => item.category,
      calculateNumber: true,
    );
    emit(
      state.copyWith(
        filteredDiscountModelItems: state.discountModelItems.loading(
          itemsLoaded: state.itemsLoaded,
        ),
        categoryDiscountModelItems: state.discountModelItems,
        locationDiscountModelItems: state.discountModelItems,
        sortingDiscountModelItems: state.discountModelItems,
        sorting: state.sorting
            .map(
              (element) => element.isSelected
                  ? element.copyWith(isSelected: false)
                  : element,
            )
            .toList(),
        filterCategory: categories,
        filterLocation: locationes,
        choosenLocationList: [],
        choosenSortingnList: [],
        categoryListEmpty: true,
        loadingStatus: state.discountModelItems.length != state.itemsLoaded
            ? LoadingStatus.loaded
            : LoadingStatus.listLoadedFull,
      ),
    );
  }

  void _onFilterCategory(
    _FilterCategory event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters = state.filterCategory
        .map(
          (element) => event.value == CategoryEnum.all
              ? element.isSelected
                  ? element.copyWith(isSelected: false)
                  : element
              : element.value == event.value
                  ? element.copyWith(isSelected: !element.isSelected)
                  : element,
        )
        .toList();

    if (selectedFilters == state.filterCategory) return;

    final categoryItems = _filterCategory(
      categories: selectedFilters,
    );
    final (:list, :loadingStatus) = _filter(
      categoryList: categoryItems,
      locationList: state.locationDiscountModelItems,
      itemsLoaded: state.itemsLoaded.getLoaded(
        list: categoryItems,
        loadItems: getItemsLoading,
      ),
    );

    // final (:list, :loadingStatus) = _filterLocation(
    //   itemsLoaded: state.itemsLoaded,
    //   locationIndex: state.filtersLocationIndex,
    //   modelList: categoryItems,
    // );

    emit(
      state.copyWith(
        filteredDiscountModelItems: list,
        filterCategory: selectedFilters,
        itemsLoaded: list.length,
        loadingStatus: loadingStatus,
        categoryDiscountModelItems: categoryItems,
        categoryListEmpty: !selectedFilters.haveSelectedValue,
        filterLocation:
            categoryItems.getLocationFilter(isEnglish: state.isEnglish),
      ),
    );
  }

  void _onFilterLocation(
    _FilterLocation event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final selectedFilters = state.filterLocation
        .map(
          (element) => element.value == event.value
              ? element.copyWith(isSelected: !element.isSelected)
              : element,
        )
        .toList();
    // checkValue(
    //   filterValue: event.value,
    //   equalValue: SubLocation.allStoresOfChain,
    // );

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
        filterLocation: selectedFilters,
        choosenLocationList: selectedFilters
            .where(
              (element) => element.isSelected,
            )
            .toList(),
        itemsLoaded: list.length,
        loadingStatus: loadingStatus,
        filterCategory: locationList.overallItems(
          isEnglish: state.isEnglish,
          getFilter: (item) => item.category,
          calculateNumber: true,
        ),
      ),
    );
  }

  void _setMobFilter(
    _SetMobFilter event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final sortingList =
        _sorting(list: state.discountModelItems, sorting: event.sorting);

    final locationList = _filterLocation(
      location: event.filterList,
      listValue: sortingList,
    );
    final categoryFilter = _filterCategory(
      categories: state.filterCategory,
      list: sortingList,
    );
    final (:list, :loadingStatus) = _filter(
      categoryList: categoryFilter,
      locationList: locationList,
      itemsLoaded: state.itemsLoaded,
    );
    emit(
      state.copyWith(
        loadingStatus: loadingStatus,
        filteredDiscountModelItems: list,
        itemsLoaded: list.length,
        choosenLocationList: event.choosenLocationList,
        categoryDiscountModelItems: categoryFilter,
        locationDiscountModelItems: locationList,
        sorting: event.sorting,
        sortingDiscountModelItems: sortingList,
        choosenSortingnList: event.choosenSortingnList,
        filterCategory: locationList.overallItems(
          isEnglish: state.isEnglish,
          getFilter: (item) => item.category,
          calculateNumber: true,
        ),
        filterLocation: event.filterList,
      ),
    );
  }

  void _onSorting(
    _Sorting event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final sorting = state.sorting
        .map(
          (element) => element.value == event.value
              ? element.copyWith(isSelected: !element.isSelected)
              : element,
        )
        .toList();
    // .checkValue(
    //   filterValue: event.value,
    //   equalValue: null,
    // );
    final sortingList =
        _sorting(list: state.discountModelItems, sorting: sorting);
    final categoryFilter = _filterCategory(
      categories: state.filterCategory,
      list: sortingList,
    );
    final locationList = _filterLocation(
      location: state.filterLocation,
      listValue: sortingList,
      // categiryList: categoryFilter,
    );
    final (:list, :loadingStatus) = _filter(
      categoryList: categoryFilter,
      locationList: locationList,
      itemsLoaded: state.itemsLoaded,
    );
    emit(
      state.copyWith(
        loadingStatus: loadingStatus,
        filteredDiscountModelItems: list,
        choosenSortingnList: sorting
            .where(
              (element) => element.isSelected,
            )
            .toList(),
        itemsLoaded: list.length,
        categoryDiscountModelItems: categoryFilter,
        locationDiscountModelItems: locationList,
        sorting: sorting,
        sortingDiscountModelItems: sortingList,
        filterCategory: locationList.overallItems(
          isEnglish: state.isEnglish,
          getFilter: (item) => item.category,
          calculateNumber: true,
        ),
      ),
    );
  }

  List<DiscountModel> _filterLocation({
    required List<FilterItem>? location,
    List<DiscountModel>? listValue,
    // List<DiscountModel>? categiryList,
  }) {
    // final items = listValue ??
    //     state.discountModelItems
    //         .where(
    //           (item) =>
    //               location == null ||
    //               !location.contains(DiscountEnum.free) ||
    //               item.discount.contains(100),
    //         )
    //         .toList();
    return (listValue ?? state.sortingDiscountModelItems).loadingFilter(
      filtersValue: location
          ?.where(
            (element) => element.isSelected,
          )
          .map(
            (e) => e.value.uk,
          )
          .toList(), //?.where((element) => element is! DiscountEnum).toList(),
      itemsLoaded: null,
      getFilter: (item) => [
        if (item.location != null)
          ...item.location!.getTrsnslation(isEnglish: false),
        if (item.subLocation != null) ...item.subLocation!._getList,
      ],
      // overallFilter: items
      //     ._getLocationItems(categiryList ?? state
      // .categoryDiscountModelItems),
      // containAnyItems: false,
    );
  }

  List<DiscountModel> _sorting({
    required List<DiscountModel> list,
    required List<SortingItem>? sorting,
  }) {
    final value = (sorting ?? state.sorting).where(
      (element) => element.isSelected,
    );
    if (value.isEmpty) return list;

    final items = list
        .where(
          (item) =>
              !value.any((element) => element.value == DiscountEnum.free) ||
              item.discount.contains(100),
        )
        .toList();
    if (value.any((element) => element.value == DiscountEnum.largestSmallest)) {
      return items
        ..sort((a, b) {
          // if (locationIndex != null && locationIndex.contains(0)) {
          final maxDiscountA =
              a.discount.isNotEmpty == true ? a.discount.reduce(max) : 0;
          final maxDiscountB =
              b.discount.isNotEmpty == true ? b.discount.reduce(max) : 0;

          return maxDiscountB.compareTo(maxDiscountA); // Descending order
        });
    } else {
      return items;
    }
  }

  List<DiscountModel> _filterCategory({
    required List<FilterItem>? categories,
    List<DiscountModel>? list,
    // List<DiscountModel>? locationList,
  }) =>
      (list ?? state.sortingDiscountModelItems).loadingFilter(
        filtersValue: categories
            ?.where(
              (element) => element.isSelected,
            )
            .map(
              (e) => e.value,
            )
            .toList(),
        itemsLoaded: null,
        getFilter: (item) => item.category,
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
      // sorting: (list) => _sorting(list: list, location: location),
    );
    return (list: list, loadingStatus: loadingStatus);
  }

  int get getItemsLoading {
    final loadingItems = _firebaseRemoteConfigProvider.getInt(loadingItemsKey);
    if (loadingItems > 0) {
      return loadingItems;
    } else {
      return KDimensions.loadItems;
    }
  }

  void _onFailure(
    _Failure event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: SomeFailure.serverError(
          error: event.error,
          stack: event.stack,
          tag: 'Discount ${ErrorText.watcherBloc}',
          tagKey: ErrorText.streamBlocKey,
        )._toDiscount(),
      ),
    );
  }

  @override
  Future<void> close() {
    _discountItemsSubscription?.cancel();
    return super.close();
  }
}

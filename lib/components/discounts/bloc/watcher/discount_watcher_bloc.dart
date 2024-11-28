import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/models/models.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discount_watcher_bloc.freezed.dart';
part 'discount_watcher_event.dart';
part 'discount_watcher_state.dart';

@Injectable(env: [Config.user])
class DiscountWatcherBloc
    extends Bloc<DiscountWatcherEvent, DiscountWatcherState> {
  DiscountWatcherBloc({
    required IDiscountRepository discountRepository,
    required UserRepository userRepository,
    // required IReportRepository reportRepository,
    // required IAppAuthenticationRepository appAuthenticationRepository,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
  })  : _discountRepository = discountRepository,
        _userRepository = userRepository,
        // _reportRepository = reportRepository,
        // _appAuthenticationRepository = appAuthenticationRepository,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        super(
          const _Initial(
            loadingStatus: LoadingStatus.initial,
            failure: null,
            sorting: [],
            unmodifiedDiscountModelItems: [],
            filterItemsModel: FilterItemsModel.empty(),
            filterDiscountModelList: [],
            filterStatus: FilterStatus.initial,
            idFilterItemsModel: IDFilterItemsModel.empty(),
            isListLoadedFull: false,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
    on<_LoadNextItems>(_onLoadNextItems);
    on<_FilterEligibilities>(_onFilterEligibilities);
    on<_FilterCategory>(_onFilterCategory);
    on<_FilterLocation>(_onFilterLocation);
    on<_SetMobFilter>(_setMobFilter);
    on<_FilterReset>(_onFilterReset);
    on<_Sorting>(_onSorting);
    // on<_GetReport>(_onGetReport);
  }

  final IDiscountRepository _discountRepository;
  final UserRepository _userRepository;
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
            discount,
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

    final filterItemsModel = FilterItemsModel.init(
      unmodifiedDiscountModelItems: event.discountItemsModel,
      isEnglish: _userRepository.isEnglish,
    );

    final idFilterItems = <String, IDFilterItem>{};

    for (final discount in event.discountItemsModel) {
      idFilterItems.addAll({
        discount.id: IDFilterItem(
          discountId: discount.id,
        ),
      });
    }

    final idFilterItemsModel = IDFilterItemsModel(value: idFilterItems);

    final filteredDiscountIdList = idFilterItemsModel.getFilteringId;

    final itemsNumber = getCurrentLoadNumber(
      unmodifiedDiscountModelItems: event.discountItemsModel,
    );

    final filterDiscountModelList = event.discountItemsModel
        .where(
          (discount) => filteredDiscountIdList.contains(discount.id),
        )
        .take(itemsNumber)
        .toList();

    emit(
      _Initial(
        unmodifiedDiscountModelItems: event.discountItemsModel,
        filterItemsModel: filterItemsModel,
        sorting: [],
        loadingStatus: LoadingStatus.loaded,
        failure: null,
        filterDiscountModelList: filterDiscountModelList,
        filterStatus: FilterStatus.initial,
        idFilterItemsModel: idFilterItemsModel,
        isListLoadedFull: filteredDiscountIdList.length == itemsNumber,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final filteredDiscountIdList = state.idFilterItemsModel.getFilteringId;

    final itemsNumber = getCurrentLoadNumber();

    if (itemsNumber == filteredDiscountIdList.length) {
      if (!state.isListLoadedFull) {
        emit(state.copyWith(isListLoadedFull: true));
      }
      return;
    }

    final currentLoadingItems = itemsNumber + getItemsLoading;

    final filterDiscounts = state.unmodifiedDiscountModelItems
        .where(
          (discount) => filteredDiscountIdList.contains(discount.id),
        )
        .take(
          currentLoadingItems,
        )
        .toList();

    emit(
      state.copyWith(
        filterDiscountModelList: filterDiscounts,
        isListLoadedFull: currentLoadingItems == filteredDiscountIdList.length,
      ),
    );
    // if (state.itemsLoaded
    //     .checkLoadingPosible(state.categoryDiscountModelItems)) {
    //   emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
    //   return;
    // }
    // // emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    // // final (:list, :loadingStatus) = _filterLocation(
    // //   itemsLoaded: state.itemsLoaded,
    // //   locationIndex: state.filtersLocationIndex,
    // //   loadItems: getItemsLoading,
    // // );
    // final (:list, :loadingStatus) = _filter(
    //   categoryList: state.categoryDiscountModelItems,
    //   locationList: state.locationDiscountModelItems,
    //   itemsLoaded: state.itemsLoaded,
    //   loadItems: getItemsLoading,
    // );
    // emit(
    //   state.copyWith(
    //     filteredDiscountModelItems: list,
    //     itemsLoaded: list.length,
    //     loadingStatus: loadingStatus,
    //   ),
    // );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.filterItemsModel.clearChooseItems();

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
      ),
    );
    // final locationes = state.discountModelItems
    //     .getLocationFilter(isEnglish: _userRepository.isEnglish);

    // final categories = state.discountModelItems.overallItems(
    //   isEnglish: state.isEnglish,
    //   getFilter: (item) => item.category,
    //   calculateNumber: true,
    // );

    // final eligibilities = state.discountModelItems.overallItems(
    //   isEnglish: _userRepository.isEnglish,
    //   getENFilter: (item) => item.eligibilityEN,
    //   getUAFilter: (item) => item.eligibility,
    //   calculateNumber: true,
    // );
    // emit(
    //   state.copyWith(
    //     filteredDiscountModelItems: state.discountModelItems.loading(
    //       itemsLoaded: state.itemsLoaded,
    //     ),
    //     categoryDiscountModelItems: state.discountModelItems,
    //     locationDiscountModelItems: state.discountModelItems,
    //     sortingDiscountModelItems: state.discountModelItems,
    //     sorting: state.sorting
    //         .map(
    //           (element) => element.isSelected
    //               ? element.copyWith(isSelected: false)
    //               : element,
    //         )
    //         .toList(),
    //     filterCategory: categories,
    //     filterLocation: locationes,
    //     filterEligibilities: eligibilities,
    //     choosenLocationList: [],
    //     choosenCategoriesnList: [],
    //     choosenEligibilitiesList: [],
    //     loadingStatus: state.discountModelItems.length != state.itemsLoaded
    //         ? LoadingStatus.loaded
    //         : LoadingStatus.listLoadedFull,
    //   ),
    // );
  }

  void _onFilterEligibilities(
    _FilterEligibilities event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.filterItemsModel.addEligibility(event.value);

    for (final discount in state.unmodifiedDiscountModelItems) {
      var hasEligibility = false;
      var hasCategory = false;
      var hasLocation = false;

      if (state.filterItemsModel.choosenEligibilitiesList.isEmpty) {
        hasEligibility = true;
      } else {
        if (discount.eligibility != null) {
          for (final eligiblity in discount.eligibility!) {
            if (state.filterItemsModel.choosenEligibilitiesList
                .containsKey(eligiblity.uk)) {
              hasEligibility = true;
            }
          }
        }
      }

      if (state.filterItemsModel.choosenCategoriesnList.isEmpty) {
        hasCategory = true;
      } else {
        for (final category in discount.category) {
          if (state.filterItemsModel.choosenCategoriesnList
              .containsKey(category.uk)) {
            hasCategory = true;
          }
        }
      }

      if (state.filterItemsModel.choosenLocationList.isEmpty) {
        hasLocation = true;
      } else {
        if (discount.location != null) {
          for (final location in discount.location!) {
            if (state.filterItemsModel.choosenLocationList
                .containsKey(location.uk)) {
              hasLocation = true;
            }
          }
        }
        if (discount.subLocation != null) {
          if (state.filterItemsModel.choosenLocationList
              .containsKey(KAppText.sublocation.uk)) {
            hasLocation = true;
          }
        }
      }

      state.idFilterItemsModel.value[discount.id] = IDFilterItem(
        discountId: discount.id,
        hasCateogries: hasCategory,
        hasEligibilities: hasEligibility,
        hasLocation: hasLocation,
      );
    }

    add(const DiscountWatcherEvent.loadNextItems());

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
      ),
    );
  }

  void _onFilterCategory(
    _FilterCategory event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.filterItemsModel.addCategory(event.value);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
      ),
    );

    // final selectedFilters = state.filterCategory
    //     .map(
    //       (element) => element.value == event.value
    //           ? element.copyWith(isSelected: !element.isSelected)
    //           : element,
    //     )
    //     .toList();

    // if (selectedFilters == state.filterCategory) return;
    // final chooseCategories = selectedFilters.selectedList;
    // final categoryItems = _filterCategory(
    //   chooseCategories: chooseCategories,
    // );
    // final (:list, :loadingStatus) = _filter(
    //   categoryList: categoryItems,
    //   locationList: state.locationDiscountModelItems,
    //   itemsLoaded: state.itemsLoaded.getLoaded(
    //     list: categoryItems,
    //     loadItems: getItemsLoading,
    //   ),
    // );

    // final locations = categoryItems.getLocationFilter(
    //   isEnglish: _userRepository.isEnglish,
    // );

    // emit(
    //   state.copyWith(
    //     filteredDiscountModelItems: list,
    //     filterCategory: selectedFilters,
    //     itemsLoaded: list.length,
    //     loadingStatus: loadingStatus,
    //     choosenCategoriesnList: chooseCategories,
    //     categoryDiscountModelItems: categoryItems,
    //     filterLocation: locations,
    //     choosenLocationList: locations.selectedList,
    //   ),
    // );
  }

  void _onFilterLocation(
    _FilterLocation event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.filterItemsModel.addLocation(event.value);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
      ),
    );
    // final selectedFilters = state.filterLocation
    //     .map(
    //       (element) => element.value == event.value
    //           ? element.copyWith(isSelected: !element.isSelected)
    //           : element,
    //     )
    //     .toList();
    // // checkValue(
    // //   filterValue: event.value,
    // //   equalValue: SubLocation.allStoresOfChain,
    // // );

    // final chooseLocation = selectedFilters.selectedList;
    // final locationList = _filterLocation(
    //   chooseLocation: chooseLocation,
    // );
    // final (:list, :loadingStatus) = _filter(
    //   categoryList: state.categoryDiscountModelItems,
    //   locationList: locationList,
    //   itemsLoaded: state.itemsLoaded,
    //   location: selectedFilters,
    // );
    // final categories = locationList
    //     .overallItems(
    //       isEnglish: _userRepository.isEnglish,
    //       getENFilter: (item) => item.categoryEN,
    //       getUAFilter: (item) => item.category,
    //       calculateNumber: true,
    //     )
    //     .map(
    //       (e) => state.choosenCategoriesnList
    //               .where(
    //                 (element) => element.value == e.value,
    //               )
    //               .isNotEmpty
    //           ? e.copyWith(isSelected: true)
    //           : e,
    //     )
    //     .toList();

    // emit(
    //   state.copyWith(
    //     filteredDiscountModelItems: list,
    //     locationDiscountModelItems: locationList,
    //     filterLocation: selectedFilters,
    //     choosenLocationList: chooseLocation,
    //     itemsLoaded: list.length,
    //     loadingStatus: loadingStatus,
    //     filterCategory: locationList.overallItems(
    //       isEnglish: state.isEnglish,
    //       getFilter: (item) => item.category,
    //       calculateNumber: true,
    //     ),
    //   ),
    // );
  }

  void _setMobFilter(
    _SetMobFilter event,
    Emitter<DiscountWatcherState> emit,
  ) {
    // final locationList = _filterLocation(
    //   chooseLocation: event.choosenLocationList,
    //   listValue: state.sortingDiscountModelItems,
    // );
    // final categoryFilter = _filterCategory(
    //   chooseCategories: event.choosenCategoriesList,
    //   list: state.sortingDiscountModelItems,
    // );
    // final eligibilitiesFilter = _filterEligebilities(
    //   chooseEligibilities: event.choosenEligibilitiesList,
    //   list: state.sortingDiscountModelItems,
    // );
    // final (:list, :loadingStatus) = _filter(
    //   categoryList: categoryFilter,
    //   locationList: locationList,
    //   itemsLoaded: state.itemsLoaded,
    // );
    // final categories = locationList.overallItems(
    //   isEnglish: _userRepository.isEnglish,
    //   getENFilter: (item) => item.categoryEN,
    //   getUAFilter: (item) => item.category,
    //   calculateNumber: true,
    // );
    // emit(
    //   state.copyWith(
    //     loadingStatus: loadingStatus,
    //     filteredDiscountModelItems: list,
    //     itemsLoaded: list.length,
    //     choosenLocationList: event.choosenLocationList,
    //     categoryDiscountModelItems: categoryFilter,
    //     locationDiscountModelItems: locationList,
    //     sorting: event.sorting,
    //     sortingDiscountModelItems: sortingList,
    //     choosenSortingnList: event.choosenSortingnList,
    //     filterCategory: locationList.overallItems(
    //       isEnglish: state.isEnglish,
    //       getFilter: (item) => item.category,
    //       calculateNumber: true,
    //     ),
    //     filterLocation: event.filterList,
    //     eligibilitiesDiscountModelItems: eligibilitiesFilter,
    //     filterEligibilities: event.filterEligibilities,
    //     choosenEligibilitiesList: event.choosenEligibilitiesList,
    //   ),
    // );
  }

  void _onSorting(
    _Sorting event,
    Emitter<DiscountWatcherState> emit,
  ) {
    // final sorting = state.sorting
    //     .map(
    //       (element) => element.value == event.value
    //           ? element.copyWith(isSelected: !element.isSelected)
    //           : element,
    //     )
    //     .toList();
    // // .checkValue(
    // //   filterValue: event.value,
    // //   equalValue: null,
    // // );
    // final sortingList =
    //     _sorting(list: state.discountModelItems, sorting: sorting);
    // emit(
    //   state.copyWith(
    //     filteredDiscountModelItems: sortingList
    //         .where(state.filteredDiscountModelItems.contains)
    //         .toList(),
    //     sorting: sorting,
    //     sortingDiscountModelItems: sortingList,
    //     filterCategory: locationList.overallItems(
    //       isEnglish: state.isEnglish,
    //       getFilter: (item) => item.category,
    //       calculateNumber: true,
    //     ),
    //   ),
    // );
  }

  // List<DiscountModel> _filterLocation({
  //   required List<FilterItem<String>>? chooseLocation,
  //   List<DiscountModel>? listValue,
  //   // List<DiscountModel>? categiryList,
  // }) {
  //   // final items = listValue ??
  //   //     state.discountModelItems
  //   //         .where(
  //   //           (item) =>
  //   //               location == null ||
  //   //               !location.contains(DiscountEnum.free) ||
  //   //               item.discount.contains(100),
  //   //         )
  //   //         .toList();
  //   return (listValue ?? state.sortingDiscountModelItems).loadingFilter(
  //     filtersValue: location
  //         ?.where(
  //           (element) => element.isSelected,
  //         )
  //         .map(
  //           (e) => e.value.uk,
  //         )
  //         .toList(), //?.where((element) => element is! DiscountEnum).toList(),
  //     itemsLoaded: null,
  //     getFilter: (item) => [
  //       if (item.location != null)
  //         ...item.location!.getTrsnslation(isEnglish: false),
  //       if (item.subLocation != null) ...item.subLocation!._getList,
  //     ],
  //     // overallFilter: items
  //     //     ._getLocationItems(categiryList ?? state
  //     // .categoryDiscountModelItems),
  //     // containAnyItems: false,
  //   );
  // }

  // List<DiscountModel> _sorting({
  //   required List<DiscountModel> list,
  //   required List<FilterItem<DiscountEnum>>? sorting,
  // }) {
  //   final value = (sorting ?? state.sorting).selectedList;
  //   if (value.isEmpty) return list;

  //   final items = list
  //       .where(
  //         (item) =>
  //             !value.any((element) => element.value == DiscountEnum.free) ||
  //             item.discount.contains(100),
  //       )
  //       .toList();
  //   if (value.any((element) => element.value == DiscountEnum.largestSmallest)) {
  //     return items
  //       ..sort((a, b) {
  //         // if (locationIndex != null && locationIndex.contains(0)) {
  //         final maxDiscountA =
  //             a.discount.isNotEmpty == true ? a.discount.reduce(max) : 0;
  //         final maxDiscountB =
  //             b.discount.isNotEmpty == true ? b.discount.reduce(max) : 0;

  //         return maxDiscountB.compareTo(maxDiscountA); // Descending order
  //       });
  //   } else {
  //     return items;
  //   }
  // }

  // List<DiscountModel> _filterCategory({
  //   required List<FilterItem<String>>? chooseCategories,
  //   List<DiscountModel>? list,
  //   // List<DiscountModel>? locationList,
  // }) =>
  //     (list ?? state.sortingDiscountModelItems).filter(
  //       filtersValue: chooseCategories
  //           ?.map(
  //             (e) => e.value,
  //           )
  //           .toList(),
  //       // itemsLoaded: null,
  //       getFilter: (item) => item.category,
  //       // listForFilter: locationList ?? state.locationDiscountModelItems,
  //     );
  // List<DiscountModel> _filterEligebilities({
  //   required List<FilterItem<String>>? chooseEligibilities,
  //   List<DiscountModel>? list,
  //   // List<DiscountModel>? locationList,
  // }) =>
  //     (list ?? state.sortingDiscountModelItems).filter(
  //       filtersValue: chooseEligibilities?.selectedList
  //           .map(
  //             (e) => e.value,
  //           )
  //           .toList(),
  //       itemsLoaded: null,
  //       getFilter: (item) => item.category,
  //       // listForFilter: locationList ?? state.locationDiscountModelItems,
  //     );

  // ({List<DiscountModel> list, LoadingStatus loadingStatus}) _filter({
  //   required List<DiscountModel> categoryList,
  //   required List<DiscountModel> locationList,
  //   required int itemsLoaded,
  //   int? loadItems,
  //   List<dynamic>? location,
  // }) {
  //   final (:list, :loadingStatus) = categoryList.combiningFilteredLists(
  //     secondList: locationList,
  //     itemsLoaded: itemsLoaded,
  //     loadItems: loadItems,
  //     // sorting: (list) => _sorting(list: list, location: location),
  //   );
  //   return (list: list, loadingStatus: loadingStatus);
  // }

  int get getItemsLoading {
    final loadingItems = _firebaseRemoteConfigProvider.getInt(loadingItemsKey);
    if (loadingItems > 0) {
      return loadingItems;
    } else {
      return KDimensions.loadItems;
    }
  }

  int getCurrentLoadNumber({
    List<DiscountModel>? unmodifiedDiscountModelItems,
  }) =>
      min(
        unmodifiedDiscountModelItems?.length ??
            state.unmodifiedDiscountModelItems.length,
        max(state.filterDiscountModelList.length, getItemsLoading),
      );

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

import 'dart:async';
import 'dart:math';

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

    late FilterItemsModel filterItemsModel;

    filterItemsModel = FilterItemsModel.init(
      unmodifiedDiscountModelItems: event.discountItemsModel,
      isEnglish: _userRepository.isEnglish,
      chosenCategories: state.filterItemsModel.chosenCategoriesList,
      chosenEligibilities: state.filterItemsModel.chosenEligibilitiesList,
      chosenLocation: state.filterItemsModel.chosenLocationList,
    );

    final itemsNumber = getCurrentLoadNumber(
      unmodifiedDiscountModelItems: event.discountItemsModel,
    );

    final filterDiscountModelList =
        filterItemsModel.getFilterList(event.discountItemsModel);

    emit(
      _Initial(
        unmodifiedDiscountModelItems: event.discountItemsModel,
        filterItemsModel: filterItemsModel,
        sorting: [],
        loadingStatus: LoadingStatus.loaded,
        failure: null,
        filterDiscountModelList:
            filterDiscountModelList.take(itemsNumber).toList(),
        filterStatus: state.filterStatus,
        isListLoadedFull: itemsNumber >= filterDiscountModelList.length,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final filterDiscountModelList = state.filterItemsModel.getFilterList(
      state.unmodifiedDiscountModelItems,
    );

    final itemsNumber = getCurrentLoadNumber();

    if (itemsNumber == filterDiscountModelList.length) {
      if (!state.isListLoadedFull) {
        emit(state.copyWith(isListLoadedFull: true));
      }
      return;
    }

    final currentLoadingItems = itemsNumber + getItemsLoading;

    emit(
      state.copyWith(
        filterDiscountModelList: filterDiscountModelList
            .take(
              currentLoadingItems,
            )
            .toList(),
        isListLoadedFull: currentLoadingItems >= filterDiscountModelList.length,
      ),
    );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filterDiscountModelList: state.unmodifiedDiscountModelItems
            .take(getCurrentLoadNumber())
            .toList(),
        filterItemsModel: FilterItemsModel.init(
          unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
          isEnglish: _userRepository.isEnglish,
          chosenCategories: const {},
          chosenLocation: const {},
          chosenEligibilities: const {},
        ),
        isListLoadedFull: state.unmodifiedDiscountModelItems.length <=
            state.filterDiscountModelList.length,
      ),
    );
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

    state.filterItemsModel.addEligibility(
      valueUK: event.value,
      unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
      isEnglish: _userRepository.isEnglish,
    );

    final itemsNumber = getCurrentLoadNumber();

    final filterDiscountModelList = state.filterItemsModel
        .getFilterList(state.unmodifiedDiscountModelItems);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
        filterDiscountModelList:
            filterDiscountModelList.take(itemsNumber).toList(),
        isListLoadedFull: filterDiscountModelList.length <= itemsNumber,
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

    state.filterItemsModel.addCategory(
      valueUK: event.value,
      unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
      isEnglish: _userRepository.isEnglish,
    );

    final itemsNumber = getCurrentLoadNumber();

    final filterDiscountModelList = state.filterItemsModel
        .getFilterList(state.unmodifiedDiscountModelItems);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
        filterDiscountModelList:
            filterDiscountModelList.take(itemsNumber).toList(),
        isListLoadedFull: filterDiscountModelList.length <= itemsNumber,
      ),
    );
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

    state.filterItemsModel.addLocation(
      valueUK: event.value,
      unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
      isEnglish: _userRepository.isEnglish,
    );

    final itemsNumber = getCurrentLoadNumber();

    final filterDiscountModelList = state.filterItemsModel
        .getFilterList(state.unmodifiedDiscountModelItems);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
        filterDiscountModelList:
            filterDiscountModelList.take(itemsNumber).toList(),
        isListLoadedFull: filterDiscountModelList.length <= itemsNumber,
      ),
    );
  }

  void _setMobFilter(
    _SetMobFilter event,
    Emitter<DiscountWatcherState> emit,
  ) {
    // final locationList = _filterLocation(
    //   chooseLocation: event.chosenLocationList,
    //   listValue: state.sortingDiscountModelItems,
    // );
    // final categoryFilter = _filterCategory(
    //   chooseCategories: event.chosenCategoriesList,
    //   list: state.sortingDiscountModelItems,
    // );
    // final eligibilitiesFilter = _filterEligebilities(
    //   chooseEligibilities: event.chosenEligibilitiesList,
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
    //     chosenLocationList: event.chosenLocationList,
    //     categoryDiscountModelItems: categoryFilter,
    //     locationDiscountModelItems: locationList,
    //     sorting: event.sorting,
    //     sortingDiscountModelItems: sortingList,
    //     chosenSortingnList: event.chosenSortingnList,
    //     filterCategory: locationList.overallItems(
    //       isEnglish: state.isEnglish,
    //       getFilter: (item) => item.category,
    //       calculateNumber: true,
    //     ),
    //     filterLocation: event.filterList,
    //     eligibilitiesDiscountModelItems: eligibilitiesFilter,
    //     filterEligibilities: event.filterEligibilities,
    //     chosenEligibilitiesList: event.chosenEligibilitiesList,
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

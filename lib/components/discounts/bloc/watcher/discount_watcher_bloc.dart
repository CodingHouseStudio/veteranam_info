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
            discountFilterRepository: DiscountFilterRepository.empty(),
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
    on<_SearchLocation>(_onSearchLocation);
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

    final discountFilterRepository = DiscountFilterRepository.init(
      unmodifiedDiscountModelItems: event.discountItemsModel,
      isEnglish: _userRepository.isEnglish,
    );

    final itemsNumber = getCurrentLoadNumber(
      unmodifiedDiscountModelItems: event.discountItemsModel,
    );

    final filterDiscountModelList =
        discountFilterRepository.getFilterList(event.discountItemsModel);

    emit(
      _Initial(
        unmodifiedDiscountModelItems: event.discountItemsModel,
        discountFilterRepository: discountFilterRepository,
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
    final filterDiscountModelList =
        state.discountFilterRepository.getFilterList(
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
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository.resetAll(
      unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
      isEnglish: _userRepository.isEnglish,
    );

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
        filterDiscountModelList: state.unmodifiedDiscountModelItems
            .take(getCurrentLoadNumber())
            .toList(),
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

    state.discountFilterRepository.addEligibility(
      valueUK: event.eligibility,
      unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
      isEnglish: _userRepository.isEnglish,
    );

    final itemsNumber = getCurrentLoadNumber();

    final filterDiscountModelList = _filter(isDesk: event.isDesk);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
        filterDiscountModelList: event.isDesk
            ? filterDiscountModelList.take(itemsNumber).toList()
            : filterDiscountModelList,
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

    state.discountFilterRepository.addCategory(
      valueUK: event.category,
      unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
      isEnglish: _userRepository.isEnglish,
    );

    final itemsNumber = getCurrentLoadNumber();

    final filterDiscountModelList = _filter(isDesk: event.isDesk);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
        filterDiscountModelList: event.isDesk
            ? filterDiscountModelList.take(itemsNumber).toList()
            : filterDiscountModelList,
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

    state.discountFilterRepository.addLocation(
      valueUK: event.location,
      unmodifiedDiscountModelItems: state.unmodifiedDiscountModelItems,
      isEnglish: _userRepository.isEnglish,
    );

    final itemsNumber = getCurrentLoadNumber();

    final filterDiscountModelList = _filter(isDesk: event.isDesk);

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
        filterDiscountModelList: event.isDesk
            ? filterDiscountModelList.take(itemsNumber).toList()
            : filterDiscountModelList,
        isListLoadedFull: filterDiscountModelList.length <= itemsNumber,
      ),
    );
  }

  void _onSearchLocation(
    _SearchLocation event,
    Emitter<DiscountWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository.locationSearch(
      event.serachText,
    );

    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtered,
      ),
    );
  }

  void _setMobFilter(
    _SetMobFilter event,
    Emitter<DiscountWatcherState> emit,
  ) {
    final itemsNumber = getCurrentLoadNumber();

    final filterDiscountModelList = state.discountFilterRepository
        .getFilterList(state.unmodifiedDiscountModelItems);

    emit(
      state.copyWith(
        filterDiscountModelList:
            filterDiscountModelList.take(itemsNumber).toList(),
        isListLoadedFull: filterDiscountModelList.length <= itemsNumber,
      ),
    );
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

  List<DiscountModel> _filter({required bool isDesk}) {
    if (isDesk) {
      return state.discountFilterRepository
          .getFilterList(state.unmodifiedDiscountModelItems);
    } else {
      return state.filterDiscountModelList;
    }
  }

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

import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discounts_watcher_bloc.freezed.dart';
part 'discounts_watcher_event.dart';
part 'discounts_watcher_state.dart';

@Injectable(env: [Config.user])
class DiscountsWatcherBloc
    extends Bloc<DiscountsWatcherEvent, DiscountsWatcherState> {
  DiscountsWatcherBloc({
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
            loadingStatus: LoadingStatus.initial,
            failure: null,
            sortingBy: null,
            unmodifiedDiscountModelItems: [],
            discountFilterRepository: DiscountFilterRepository.empty(),
            filterDiscountModelList: [],
            filterStatus: FilterStatus.initial,
            isListLoadedFull: false,
            sortingDiscountModelList: [],
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
    on<_MobSetFilter>(_onMobSetFilter);
    on<_MobRevertFilter>(_onMobRevertFilter);
    on<_MobSaveFilter>(_onMobSaveFilter);
    on<_FilterReset>(_onFilterReset);
    on<_Sorting>(_onSorting);

    add(const DiscountsWatcherEvent.started());
    // on<_GetReport>(_onGetReport);
  }

  final IDiscountRepository _discountRepository;
  // final UserRepository _userRepository;
  StreamSubscription<List<DiscountModel>>? _discountItemsSubscription;
  // final IReportRepository _reportRepository;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;

  @visibleForTesting
  static const loadingItemsKey = DiscountConfigCubit.loadingItemsKey;
  @visibleForTesting
  static IDiscountFilterRepository? testDiscountFilterRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountsWatcherState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
        filterStatus: FilterStatus.loading,
        discountFilterRepository:
            testDiscountFilterRepository ?? DiscountFilterRepository.init(),
      ),
    );

    // final reportItems = await _getReport();
    // Wait for initialize remote config if it didn't happen yet
    await _firebaseRemoteConfigProvider.waitActivated();

    await _discountItemsSubscription?.cancel();
    _discountItemsSubscription = _discountRepository
        .getDiscountItems(
      showOnlyBusinessDiscounts: _firebaseRemoteConfigProvider.getBool(
        RemoteConfigKey.showOnlyBusinessDiscounts,
      ),
      // reportIdItems: reportItems?.getIdCard,
    )
        .listen(
      (discount) {
        add(
          DiscountsWatcherEvent.updated(
            discount,
          ),
        );
      },
      onError: (Object error, StackTrace stack) {
        add(DiscountsWatcherEvent.failure(error: error, stack: stack));
      },
    );
  }

  Future<void> _onUpdated(
    _Updated event,
    Emitter<DiscountsWatcherState> emit,
  ) async {
    if (event.discountItemsModel.isEmpty && Config.isProduction) {
      return;
    }

    final discountSortingList =
        _sorting(discountsList: event.discountItemsModel);

    SomeFailure? failure;

    state.discountFilterRepository
        .getFilterValuesFromDiscountItems(
          event.discountItemsModel,
        )
        .leftMap(
          (l) => failure = l,
        );

    final itemsNumber = getCurrentLoadNumber(
      sortingDiscountModelItems: discountSortingList,
    );

    var filterList = event.discountItemsModel;

    state.discountFilterRepository.getFilterList(discountSortingList).fold(
          (l) => failure = l,
          (r) => filterList = r,
        );

    emit(
      _Initial(
        unmodifiedDiscountModelItems: event.discountItemsModel,
        discountFilterRepository: state.discountFilterRepository,
        sortingBy: state.sortingBy,
        loadingStatus: LoadingStatus.loaded,
        failure: failure,
        filterDiscountModelList: filterList.take(itemsNumber).toList(),
        filterStatus:
            failure != null ? FilterStatus.error : FilterStatus.filtered,
        isListLoadedFull: itemsNumber >= filterList.length,
        sortingDiscountModelList: discountSortingList,
      ),
    );
  }

  void _onLoadNextItems(
    _LoadNextItems event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.isListLoadedFull) return;
    state.discountFilterRepository
        .getFilterList(
      state.sortingDiscountModelList,
    )
        .fold(
      (l) => emit(
        state.copyWith(
          failure: l,
          filterStatus: FilterStatus.error,
        ),
      ),
      (r) {
        final itemsNumber = getCurrentLoadNumber();

        // if (itemsNumber == r.length) {
        //   emit(state.copyWith(isListLoadedFull: true));
        //   return;
        // }

        final currentLoadingItems = itemsNumber + getItemsLoading;

        emit(
          state.copyWith(
            filterDiscountModelList: r
                .take(
                  currentLoadingItems,
                )
                .toList(),
            isListLoadedFull: currentLoadingItems >= r.length,
          ),
        );
      },
    );
  }

  void _onFilterReset(
    _FilterReset event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.filterStatus.processing) return;
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository
        .resetAll(
          state.sortingDiscountModelList,
        )
        .fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          ),
          (r) => emit(
            state.copyWith(
              filterStatus: FilterStatus.filtered,
              filterDiscountModelList: state.sortingDiscountModelList
                  .take(getCurrentLoadNumber())
                  .toList(),
              isListLoadedFull: state.sortingDiscountModelList.length <=
                  state.filterDiscountModelList.length,
            ),
          ),
        );
  }

  void _onFilterEligibilities(
    _FilterEligibilities event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.filterStatus.processing) return;
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository
        .addRemoveEligibility(
          valueUK: event.eligibility,
          unmodifiedDiscountModelItems: state.sortingDiscountModelList,
        )
        .fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          ),
          (r) => _filter(isDesk: event.isDesk, emit: emit),
        );
  }

  void _onFilterCategory(
    _FilterCategory event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.filterStatus.processing) return;
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository
        .addRemoveCategory(
          valueUK: event.category,
          unmodifiedDiscountModelItems: state.sortingDiscountModelList,
        )
        .fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          ),
          (r) => _filter(isDesk: event.isDesk, emit: emit),
        );
  }

  void _onFilterLocation(
    _FilterLocation event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.filterStatus.processing) return;
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository
        .addRemoveLocation(
          valueUK: event.location,
          unmodifiedDiscountModelItems: state.sortingDiscountModelList,
        )
        .fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          ),
          (r) => _filter(isDesk: event.isDesk, emit: emit),
        );
  }

  void _onSearchLocation(
    _SearchLocation event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.filterStatus.processing) return;
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository
        .locationSearch(
          event.serachText,
        )
        .fold(
          (l) => emit(
            state.copyWith(
              filterStatus: FilterStatus.error,
              failure: l,
            ),
          ),
          (r) => emit(
            state.copyWith(
              filterStatus: FilterStatus.filtered,
            ),
          ),
        );
  }

  void _onMobSetFilter(
    _MobSetFilter event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    final itemsNumber = getCurrentLoadNumber();

    state.discountFilterRepository.locationSearch('');

    state.discountFilterRepository
        .getFilterList(state.sortingDiscountModelList)
        .fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          ),
          (r) => emit(
            state.copyWith(
              filterDiscountModelList: r.take(itemsNumber).toList(),
              isListLoadedFull: r.length <= itemsNumber,
            ),
          ),
        );
  }

  void _onMobRevertFilter(
    _MobRevertFilter event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.filterStatus.processing) return;
    emit(
      state.copyWith(
        filterStatus: FilterStatus.filtering,
      ),
    );

    state.discountFilterRepository
        .revertActiveFilter(state.unmodifiedDiscountModelItems)
        .fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          ),
          (r) => emit(
            state.copyWith(
              filterStatus: FilterStatus.filtered,
            ),
          ),
        );
  }

  void _onMobSaveFilter(
    _MobSaveFilter event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    state.discountFilterRepository.saveActiveFilter();
    // .fold(
    //       (l) => emit(
    //         state.copyWith(
    //           failure: l,
    //           filterStatus: FilterStatus.error,
    //         ),
    //       ),
    //       (r) => emit(
    //         state.copyWith(
    //           filterStatus: state.filterStatus,
    //         ),
    //       ),
    //     );
  }

  void _onSorting(
    _Sorting event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    if (state.sortingBy == event.value) return;
    final discountSortingList = _sorting(sortingBy: event.value);

    final itemsNumber = getCurrentLoadNumber();

    state.discountFilterRepository.getFilterList(discountSortingList).fold(
          (l) => emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          ),
          (r) => emit(
            state.copyWith(
              filterDiscountModelList: r.take(itemsNumber).toList(),
              sortingBy: event.value,
              isListLoadedFull: r.length <= itemsNumber,
              sortingDiscountModelList: discountSortingList,
            ),
          ),
        );
  }

  void _filter({
    required bool isDesk,
    required Emitter<DiscountsWatcherState> emit,
    List<DiscountModel>? discountsList,
  }) {
    if (isDesk) {
      return state.discountFilterRepository
          .getFilterList(discountsList ?? state.sortingDiscountModelList)
          .fold(
        (l) {
          emit(
            state.copyWith(
              failure: l,
              filterStatus: FilterStatus.error,
            ),
          );
        },
        (r) {
          final itemsNumber = getCurrentLoadNumber();

          emit(
            state.copyWith(
              filterStatus: FilterStatus.filtered,
              filterDiscountModelList: r.take(itemsNumber).toList(),
              isListLoadedFull: r.length <= itemsNumber,
            ),
          );
        },
      );
    } else {
      emit(
        state.copyWith(
          filterStatus: FilterStatus.filtered,
        ),
      );
    }
  }

  List<DiscountModel> _sorting({
    List<DiscountModel>? discountsList,
    DiscountEnum? sortingBy,
  }) {
    final list = discountsList ?? state.unmodifiedDiscountModelItems;
    if (KTest.discountSortingTestValue) return list;
    return List.from(list)
      ..sort(
        (a, b) {
          switch (sortingBy ?? state.sortingBy) {
            case null:
            case DiscountEnum.featured:
              if (a.isVerified == b.isVerified) {
                return b.dateVerified
                    .compareTo(a.dateVerified); // Descending order
              }
              return b.isVerified ? -1 : 1;
            case DiscountEnum.largestSmallest:
              final maxDiscountA =
                  a.discount.isNotEmpty == true ? a.discount.reduce(max) : 0;
              final maxDiscountB =
                  b.discount.isNotEmpty == true ? b.discount.reduce(max) : 0;

              return maxDiscountB.compareTo(maxDiscountA); // Descending order
            case DiscountEnum.byDate:
              return b.dateVerified
                  .compareTo(a.dateVerified); // Descending order
          }
        },
      );
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
    List<DiscountModel>? sortingDiscountModelItems,
  }) =>
      min(
        sortingDiscountModelItems?.length ??
            state.sortingDiscountModelList.length,
        max(state.filterDiscountModelList.length, getItemsLoading),
      );

  void _onFailure(
    _Failure event,
    Emitter<DiscountsWatcherState> emit,
  ) {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: SomeFailure.value(
          error: event.error,
          stack: event.stack,
          tag: 'Discount ${ErrorText.watcherBloc}',
          tagKey: ErrorText.streamBlocKey,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _discountItemsSubscription?.cancel();
    return super.close();
  }
}

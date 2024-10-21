import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'my_discounts_watcher_bloc.freezed.dart';
part 'my_discounts_watcher_event.dart';
part 'my_discounts_watcher_state.dart';

@Injectable(env: [Config.business])
class MyDiscountsWatcherBloc
    extends Bloc<MyDiscountsWatcherEvent, MyDiscountsWatcherState> {
  MyDiscountsWatcherBloc({
    required IDiscountRepository discountRepository,
    required ICompanyRepository companyRepository,
  })  : _discountRepository = discountRepository,
        _companyRepository = companyRepository,
        super(
          const MyDiscountsWatcherState(
            discountsModelItems: [],
            loadingStatus: LoadingStatus.initial,
            loadedDiscountsModelItems: [],
            itemsLoaded: 0,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_DeleteDiscount>(_onDeleteDiscount);
    on<_LoadNextItems>(_onLoadNextItems);
    // on<_Deactivate>(_onDeactivate);
    on<_ChangeDeactivate>(_onChangeDeactivate);
    on<_Updated>(_onUpdated);
    on<_Failure>(_onFailure);
  }

  final IDiscountRepository _discountRepository;
  StreamSubscription<List<DiscountModel>>? _discountItemsSubscription;
  final ICompanyRepository _companyRepository;
  // Timer? _debounceTimer;

  // Future<void> _onStarted(
  //   _Started event,
  //   Emitter<MyDiscountsWatcherState> emit,
  // ) async {
  //   emit(state.copyWith(loadingStatus: LoadingStatus.loading));

  //   final result = await _discountRepository.getDiscountsByUserId(
  //     _iAppAuthenticationRepository.currentUser.id,
  //   );
  //   result.fold(
  //     (l) => emit(
  //       state.copyWith(
  //         failure: l._toMyDiscount(),
  //         loadingStatus: LoadingStatus.error,
  //       ),
  //     ),
  //     (r) {
  //       final itemsLoaded = state.itemsLoaded.getLoaded(
  //         list: r,
  //         loadItems: KDimensions.loadItems,
  //       );
  //       emit(
  //         MyDiscountsWatcherState(
  //           discountsModelItems: r,
  //           loadingStatus: r.length > itemsLoaded
  //               ? LoadingStatus.loaded
  //               : LoadingStatus.listLoadedFull,
  //           loadedDiscountsModelItems: _loading(
  //             itemsLoaded: state.itemsLoaded,
  //             loadItems: itemsLoaded,
  //             // reportItems: reportItems,
  //             list: r,
  //           ),
  //           itemsLoaded: itemsLoaded,
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _onStarted(
    _Started event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    if (_companyRepository.currentUserCompany.id.isNotEmpty) {
      await _discountItemsSubscription?.cancel();
      _discountItemsSubscription = _discountRepository
          .getDiscountsByCompanyId(
        _companyRepository.currentUserCompany.id,
      )
          .listen(
        (discount) {
          add(
            MyDiscountsWatcherEvent.updated(
              discount,
            ),
          );
        },
        onError: (dynamic error, StackTrace stack) {
          // debugPrint('error is $error');
          add(MyDiscountsWatcherEvent.failure(error: error, stack: stack));
        },
      );
    }
  }

  Future<void> _onUpdated(
    _Updated event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    final itemsLoaded = state.itemsLoaded.getLoaded(
      list: event.discountItemsModel,
      loadItems: KDimensions.loadItems,
    );
    emit(
      MyDiscountsWatcherState(
        discountsModelItems: event.discountItemsModel,
        loadingStatus: event.discountItemsModel.length > itemsLoaded
            ? LoadingStatus.loaded
            : LoadingStatus.listLoadedFull,
        loadedDiscountsModelItems: _loading(
          itemsLoaded: state.itemsLoaded,
          loadItems: itemsLoaded,
          // reportItems: reportItems,
          list: event.discountItemsModel,
        ),
        itemsLoaded: itemsLoaded,
      ),
    );
  }

  Future<void> _onDeleteDiscount(
    _DeleteDiscount event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    final deleteResult = await _discountRepository.deleteDiscountsById(
      event.discountId,
    );
    deleteResult.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toMyDiscount(),
          // loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          failure: null,
          // loadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }

  List<DiscountModel> _loading({
    required int itemsLoaded,
    required int? loadItems,
    List<DiscountModel>? list,
    // List<ReportModel>? reportItems,
  }) {
    // final reportItemsValue = reportItems ?? state.reportItems;
    return (list ?? state.discountsModelItems)
        // .where(
        //   (item) => reportItemsValue.every(
        //     (report) => report.cardId != item.id,
        //   ),
        // )
        // .toList()
        .loading(
      itemsLoaded: itemsLoaded,
      loadItems: loadItems,
    );
  }

  Future<void> _onLoadNextItems(
    _LoadNextItems event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    if (state.itemsLoaded.checkLoadingPosible(state.discountsModelItems)) {
      emit(state.copyWith(loadingStatus: LoadingStatus.listLoadedFull));
      return;
    }

    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    final filterItems = _loading(
      itemsLoaded: state.itemsLoaded,
      loadItems: KDimensions.loadItems,
    );

    emit(
      state.copyWith(
        loadedDiscountsModelItems: filterItems,
        itemsLoaded: (state.itemsLoaded + KDimensions.loadItems).getLoaded(
          list: filterItems,
          loadItems: KDimensions.loadItems,
        ),
        loadingStatus: filterItems.length == state.discountsModelItems.length
            ? LoadingStatus.listLoadedFull
            : LoadingStatus.loaded,
      ),
    );
  }

  // Future<void> _onDeactivate(
  //   _Deactivate event,
  //   Emitter<MyDiscountsWatcherState> emit,
  // ) async {
  //   add(
  //     MyDiscountsWatcherEvent.changeDeactivate(
  //       discountModel: event.discountModel,
  //       isDeactivate: event.isDeactivate,
  //     ),
  //   );
  // if (_debounceTimer?.isActive ?? false) {
  //   _debounceTimer?.cancel();
  //   _debounceTimer = null;
  //   return;
  // }
  // if (!(_debounceTimer?.isActive ?? false)) {
  //   _debounceTimer = Timer(Duration(seconds: KTest.isTest ? 0 : 5),
  //() async {
  //     add(
  //       MyDiscountsWatcherEvent.changeDeactivate(
  //         discountModel: event.discountModel,
  //         isDeactivate: event.isDeactivate,
  //       ),
  //     );
  //   });
  // }
  // }

  Future<void> _onChangeDeactivate(
    _ChangeDeactivate event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    final result = await _discountRepository.deactivateDiscount(
      discountModel: event.discountModel,
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          // failure: MyDiscountFailure.error,
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          failure: null,
          loadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }

  void _onFailure(
    _Failure event,
    Emitter<MyDiscountsWatcherState> emit,
  ) {
    // debugPrint('error is ${event.failure}');
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.error,
        failure: SomeFailure.serverError(
          error: event.error,
          stack: event.stack,
        )._toMyDiscount(),
      ),
    );
  }

  @override
  Future<void> close() {
    _discountItemsSubscription?.cancel();
    // timer.close();
    return super.close();
  }
}

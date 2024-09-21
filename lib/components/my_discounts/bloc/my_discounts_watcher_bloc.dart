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
    required IAppAuthenticationRepository iAppAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _iAppAuthenticationRepository = iAppAuthenticationRepository,
        super(
          const MyDiscountsWatcherState(
            discountsModelItems: [],
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
    on<_DeleteDiscount>(_onDeleteDiscount);
  }

  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _iAppAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    final result = await _discountRepository.getDiscountsByUserId(
      _iAppAuthenticationRepository.currentUser.id,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: l._toMyDiscount(),
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        MyDiscountsWatcherState(
          discountsModelItems: r,
          loadingStatus: LoadingStatus.loaded,
        ),
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
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) async {
        final updatedDiscounts =
            List<DiscountModel>.from(state.discountsModelItems)
              ..removeWhere((discount) => discount.id == event.discountId);

        emit(
          state.copyWith(
            discountsModelItems: updatedDiscounts,
          ),
        );
      },
    );
  }
}

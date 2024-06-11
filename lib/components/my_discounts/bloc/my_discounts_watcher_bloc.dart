import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kozak/shared/shared.dart';

part 'my_discounts_watcher_event.dart';
part 'my_discounts_watcher_state.dart';
part 'my_discounts_watcher_bloc.freezed.dart';

@Injectable()
class MyDiscountsWatcherBloc
    extends Bloc<MyDiscountsWatcherEvent, MyDiscountsWatcherState> {
  MyDiscountsWatcherBloc({
    required IDiscountRepository discountRepository,
    required IAppAuthenticationRepository iAppAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _iAppAuthenticationRepository = iAppAuthenticationRepository,
        super(const MyDiscountsWatcherState.initial()) {
    on<_Started>(_onStarted);
    on<_DeleteDiscount>(_onDeleteDiscount);
  }

  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _iAppAuthenticationRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    emit(const MyDiscountsWatcherState.loading());

    final result = await _discountRepository.getDiscountsById(
      _iAppAuthenticationRepository.currentUser.id,
    );
    result.fold(
      (l) => emit(
        MyDiscountsWatcherState.failure(l.toMyDiscount()),
      ),
      (r) => emit(MyDiscountsWatcherState.success(discountsModelItems: r)),
    );
  }

  Future<void> _onDeleteDiscount(
    _DeleteDiscount event,
    Emitter<MyDiscountsWatcherState> emit,
  ) async {
    final currentState = state;
    if (currentState is MyDiscountsWatcherStateSuccess) {
      final deleteResult = await _discountRepository.deleteDiscountsById(
        event.discountId,
      );
      deleteResult.fold(
        (l) => emit(MyDiscountsWatcherState.failure(l.toMyDiscount())),
        (r) async {
          // emit list
          //add(MyDiscountsWatcherEvent.started());

          final fetchResult = await _discountRepository.getDiscountsById(
            _iAppAuthenticationRepository.currentUser.id,
          );
          fetchResult.fold(
            (l) => emit(MyDiscountsWatcherState.failure(l.toMyDiscount())),
            (discounts) => emit(
              MyDiscountsWatcherState.success(
                discountsModelItems: discounts,
              ),
            ),
          );
        },
      );
    }
  }
}

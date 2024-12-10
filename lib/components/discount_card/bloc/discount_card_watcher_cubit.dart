import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

// part 'discount_card_watcher_event.dart';
part 'discountcard_watcher_state.dart';
part 'discount_card_watcher_cubit.freezed.dart';

@Injectable()
class DiscountCardWatcherCubit extends Cubit<DiscountCardWatcherState> {
  DiscountCardWatcherCubit({
    required IDiscountRepository discountRepository,
    @factoryParam String? id,
  })  : _discountRepository = discountRepository,
        super(
          const _Initial(
            discountModel: null,
            loadingStatus: LoadingStatus.initial,
            failure: null,
          ),
        ) {
    const _Initial(
      discountModel: null,
      loadingStatus: LoadingStatus.initial,
      failure: null,
    );
    _onStarted(
      id: id,
      // emit: ,
    );
  }
  final IDiscountRepository _discountRepository;
  Future<void> _onStarted({
    // required Emitter<DiscountCardWatcherState> emit,
    required String? id,
  }) async {
    if (id == null || id.isEmpty) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          failure: DiscountCardFailure.wrongID,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
        failure: null,
      ),
    );

    final result = await _discountRepository.getDiscount(id);

    result.fold(
      (l) => emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          failure: l._toDiscountCard(),
        ),
      ),
      (r) => emit(
        DiscountCardWatcherState(
          discountModel: r,
          loadingStatus: LoadingStatus.loaded,
          failure: null,
        ),
      ),
    );
  }
}

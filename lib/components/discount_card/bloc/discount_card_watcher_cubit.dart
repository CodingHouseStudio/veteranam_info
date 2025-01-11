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
    @factoryParam required String? id,
  })  : _discountRepository = discountRepository,
        super(
          const _Initial(
            discountModel: null,
            loadingStatus: LoadingStatus.initial,
            failure: null,
          ),
        ) {
    onStarted(
      id: id,
      // emit: ,
    );
  }
  final IDiscountRepository _discountRepository;

  @visibleForTesting
  Future<void> onStarted({
    // required Emitter<DiscountCardWatcherState> emit,
    required String? id,
  }) async {
    if (id == null || id.isEmpty) {
      emit(
        const _Initial(
          loadingStatus: LoadingStatus.error,
          failure: SomeFailure.wrongID,
          discountModel: null,
        ),
      );
      return;
    }
    emit(
      const _Initial(
        loadingStatus: LoadingStatus.loading,
        failure: null,
        discountModel: null,
      ),
    );

    final result = await _discountRepository.getDiscount(
      id: id,
      showOnlyBusinessDiscounts: false,
    );

    result.fold(
      (l) => emit(
        _Initial(
          loadingStatus: LoadingStatus.error,
          failure: l,
          discountModel: null,
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

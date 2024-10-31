import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discount_card_watcher_event.dart';
part 'discountcard_watcher_state.dart';
part 'discount_card_watcher_bloc.freezed.dart';

@Injectable()
class DiscountCardWatcherBloc
    extends Bloc<DiscountCardWatcherEvent, DiscountCardWatcherState> {
  DiscountCardWatcherBloc({
    required IDiscountRepository discountRepository,
  })  : _discountRepository = discountRepository,
        super(
          const _Initial(
            discountModel: null,
            loadingStatus: LoadingStatus.initial,
            failure: null,
          ),
        ) {
    on<_Started>(_onStarted);
  }
  final IDiscountRepository _discountRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountCardWatcherState> emit,
  ) async {
    if (event.id == null || event.id!.isEmpty) {
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

    final result = await _discountRepository.getDiscount(event.id!);

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

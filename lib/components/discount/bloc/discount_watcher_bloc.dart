import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discount_watcher_event.dart';
part 'discount_watcher_state.dart';
part 'discount_watcher_bloc.freezed.dart';

@Injectable(env: [Config.user])
class DiscountWatcherBloc
    extends Bloc<DiscountWatcherEvent, DiscountWatcherState> {
  DiscountWatcherBloc({
    required IDiscountRepository discountRepository,
    @factoryParam required DiscountModel? discount,
    @factoryParam required String? discountId,
  })  : _discountRepository = discountRepository,
        super(
          _Initial(
            discountModel: KMockText.discountModel,
            loadingStatus: LoadingStatus.initial,
          ),
        ) {
    on<_Started>(_onStarted);
    add(
      DiscountWatcherEvent.started(
        discount: discount,
        discountId: discountId,
      ),
    );
  }
  final IDiscountRepository _discountRepository;
  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    emit(
      state.copyWith(loadingStatus: LoadingStatus.loading),
    );
    DiscountModel? discount;
    if (event.discount != null) {
      discount = event.discount;
    } else if (event.discountId != null) {
      final result = await _discountRepository.getDiscount(
        event.discountId!,
      );
      result.fold(
        (l) => emit(state.copyWith(failure: DiscountFailure.linkWrong)),
        (r) => discount = r,
      );
    }

    if (discount != null) {
      emit(
        _Initial(discountModel: discount!, loadingStatus: LoadingStatus.loaded),
      );
    }
  }
}

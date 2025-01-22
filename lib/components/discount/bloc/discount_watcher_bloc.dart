import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'discount_watcher_event.dart';
part 'discount_watcher_state.dart';
part 'discount_watcher_bloc.freezed.dart';

@injectable
class DiscountWatcherBloc
    extends Bloc<DiscountWatcherEvent, DiscountWatcherState> {
  DiscountWatcherBloc({
    required IDiscountRepository discountRepository,
    required FirebaseRemoteConfigProvider firebaseRemoteConfigProvider,
    @factoryParam required DiscountModel? discount,
    @factoryParam required String? discountId,
  })  : _discountRepository = discountRepository,
        _firebaseRemoteConfigProvider = firebaseRemoteConfigProvider,
        super(
          _Initial(
            discountModel: discount ?? KMockText.discountModel,
            loadingStatus:
                discount == null ? LoadingStatus.initial : LoadingStatus.loaded,
          ),
        ) {
    on<_Started>(_onStarted);
    if (discount == null) {
      add(
        DiscountWatcherEvent.started(
          discountId,
        ),
      );
    }
  }
  final IDiscountRepository _discountRepository;
  final FirebaseRemoteConfigProvider _firebaseRemoteConfigProvider;
  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountWatcherState> emit,
  ) async {
    if (event.discountId == null || event.discountId!.isEmpty) {
      emit(
        state.copyWith(
          failure: SomeFailure.linkWrong,
          loadingStatus: LoadingStatus.error,
        ),
      );
      return;
    }

    emit(
      state.copyWith(loadingStatus: LoadingStatus.loading),
    );

    // Wait for initialize remote config if it didn't happen yet
    await _firebaseRemoteConfigProvider.waitActivated();

    final result = await _discountRepository.getDiscount(
      id: event.discountId!,
      showOnlyBusinessDiscounts: _firebaseRemoteConfigProvider
          .getBool(RemoteConfigKey.showOnlyBusinessDiscounts),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          failure: SomeFailure.linkWrong,
          loadingStatus: LoadingStatus.error,
        ),
      ),
      (r) => emit(
        _Initial(discountModel: r, loadingStatus: LoadingStatus.loaded),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Injectable(env: [Config.user])
class DiscountLinkCubit extends Cubit<bool> {
  DiscountLinkCubit({
    required IDiscountRepository discountRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(true) {
    started();
  }
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;
  Future<void> started() async {
    final result = await _discountRepository
        .userCanSendLink(_appAuthenticationRepository.currentUser.id);
    if (!isClosed) {
      result.fold(
        (l) => emit(false),
        emit,
      );
    }
  }
}

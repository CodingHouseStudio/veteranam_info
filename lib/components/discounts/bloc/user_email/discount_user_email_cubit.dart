import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable()
class DiscountUserEmailCubit extends Cubit<bool> {
  DiscountUserEmailCubit({
    required IDiscountRepository discountRepository,
    required IAppAuthenticationRepository appAuthenticationRepository,
  })  : _discountRepository = discountRepository,
        _appAuthenticationRepository = appAuthenticationRepository,
        super(true);
  final IDiscountRepository _discountRepository;
  final IAppAuthenticationRepository _appAuthenticationRepository;
  Future<void> started() async {
    final result = await _discountRepository
        .userCanSendUserEmail(_appAuthenticationRepository.currentUser.id);
    result.fold(
      (l) => emit(false),
      emit,
    );
  }
}

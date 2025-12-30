import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:veteranam/shared/shared_dart.dart';

part 'user_role_event.dart';
part 'user_role_state.dart';
part 'user_role_bloc.freezed.dart';

@Injectable(env: [Config.development])
class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  UserRoleBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(
          const _Initial(
            userRole: UserRole.civilian,
            formState: UserRoleEnum.initial,
          ),
        ) {
    on<_ChangeUserRole>(_onChangeUserRole);
    on<_Send>(_onSend);
  }

  final UserRepository _userRepository;

  void _onChangeUserRole(
    _ChangeUserRole event,
    Emitter<UserRoleState> emit,
  ) {
    emit(
      _Initial(
        userRole: event.userRole,
        formState: UserRoleEnum.inProgress,
      ),
    );
  }

  Future<void> _onSend(
    _Send event,
    Emitter<UserRoleState> emit,
  ) async {
    final userSetting =
        _userRepository.currentUserSetting.copyWith(userRole: state.userRole);
    final result =
        await _userRepository.updateUserSetting(userSetting: userSetting);
    emit(
      result.fold(
        (l) => state.copyWith(
          formState: UserRoleEnum.error,
        ),
        (r) => state.copyWith(
          formState: UserRoleEnum.success,
        ),
      ),
    );
  }
}

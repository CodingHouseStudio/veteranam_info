part of 'user_role_bloc.dart';

@freezed
class UserRoleState with _$UserRoleState {
  const factory UserRoleState({
    required UserRole userRole,
    required UserRoleEnum formState,
  }) = _Initial;
}

enum UserRoleEnum { initial, inProgress, success, error, invalidData }

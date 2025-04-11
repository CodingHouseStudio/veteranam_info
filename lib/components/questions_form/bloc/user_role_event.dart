part of 'user_role_bloc.dart';

@freezed
sealed class UserRoleEvent with _$UserRoleEvent {
  const factory UserRoleEvent.changeUserRole(UserRole userRole) =
      _ChangeUserRole;
  const factory UserRoleEvent.send() = _Send;
}

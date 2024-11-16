part of 'user_role_bloc.dart';

@freezed
class UserRoleEvent with _$UserRoleEvent {
  const factory UserRoleEvent.changeUserRole(UserRole userRole) =
      _ChangeUserRole;
  const factory UserRoleEvent.send() = _Send;
}

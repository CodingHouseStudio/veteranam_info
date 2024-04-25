import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kozak/shared/shared.dart';

part 'user_setting_model.freezed.dart';
part 'user_setting_model.g.dart';

@freezed
class UserSetting with _$UserSetting {
  const factory UserSetting({
    required String id,
    @Default(Language.ukrain) Language locale,
    UserRole? userRole,
    @Default(false) bool roleIsConfirmed,
  }) = _UserSetting;

  factory UserSetting.fromJson(Map<String, dynamic> json) =>
      _$UserSettingFromJson(json);

  /// Empty userSetting which represents an unauthenticated user.
  static const empty = UserSetting(id: '');
}

enum UserRole {
  veteran,
  relativeOfVeteran,
  civilian,
  businessmen,
}

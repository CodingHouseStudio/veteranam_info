import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

part 'user_setting_model.freezed.dart';
part 'user_setting_model.g.dart';

@freezed
class UserSetting with _$UserSetting {
  const factory UserSetting({
    required String id,
    List<DeviceModel?>? devicesSetting,
    @Default(Language.ukrain) Language locale,
    UserRole? userRole,
    @Default(false) bool roleIsConfirmed,
  }) = _UserSetting;

  // Add this private constructor
  const UserSetting._();

  factory UserSetting.fromJson(Map<String, dynamic> json) =>
      _$UserSettingFromJson(json);

  /// Empty userSetting which represents an unauthenticated user.
  static const empty = UserSetting(id: '');

  /// Convenience getter to determine whether the current user setting is empty.
  bool get isEmpty => this == UserSetting.empty.copyWith(locale: this.locale);

  /// Convenience getter to determine whether the current user setting is
  /// not empty.
  bool get isNotEmpty =>
      this != UserSetting.empty.copyWith(locale: this.locale);

  /// Convenience getter to determine whether the current user is not empty.
  bool get isDeviceEmpty =>
      devicesSetting == null ||
      devicesSetting!.isEmpty ||
      devicesSetting!.every(
        (deviceSetting) => deviceSetting == null || deviceSetting.isEmpty,
      );
}

enum UserRole {
  veteran,
  relativeOfVeteran,
  civilian,
  businessmen,
}

enum Language {
  ukrain(
    Locale('uk', 'UK'),
    // Assets.indonesia,
    'UA',
  ),
  english(
    Locale('en', 'US'),
    // Assets.english,
    'EN',
  );

  /// Add another languages support here
  const Language(this.value, this.text);

  bool get isEnglish => this == english;

  final Locale value;
  // final AssetGenImage
  //     image; // Optional: this properties used for ListTile details
  final String text; // Optional: this properties used for ListTile details
}

// extension LanguageExtension on Language {
//   static List<Language> get getAllLanguage {
//     return Language.values.map((lang) => lang).toList();
//   }
// }

// extension GetLanguage on String {
//   Language get getLocale {
//     switch (toUpperCase()) {
//       case 'UA':
//         // case 'uk':
//         return Language.ukrain;
//       case 'EN':
//         return Language.english;
//       default:
//         return Language.ukrain;
//     }
//   }
// }

abstract class UserSettingModelJsonField {
  static const id = 'id';
  static const locale = 'locale';
  static const userRole = 'userRole';
  static const roleIsConfirmed = 'roleIsConfirmed';
}

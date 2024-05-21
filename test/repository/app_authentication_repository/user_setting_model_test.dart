import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.appAuthentication} ${KGroupText.model} User Setting',
      () {
    test('check is Empty ', () {
      expect(
        KTestText.userSettingModel.isEmpty,
        isFalse,
      );

      expect(
        UserSetting.empty.isEmpty,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestText.userSettingModel.isNotEmpty,
        isTrue,
      );

      expect(
        UserSetting.empty.isNotEmpty,
        isFalse,
      );
    });
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.userSettingModel.id,
          'locale': _$LanguageEnumMap[KTestText.userSettingModel.locale],
          'userRole': _$UserRoleEnumMap[KTestText.userSettingModel.userRole],
          'roleIsConfirmed': KTestText.userSettingModel.roleIsConfirmed,
          'timeSendingFeedback':
              KTestText.userSettingModel.timeSendingFeedback?.toIso8601String(),
        };

        final userSettingModel = UserSetting.fromJson(json);

        expect(userSettingModel.id, KTestText.userSettingModel.id);
        expect(userSettingModel.locale, KTestText.userSettingModel.locale);
        expect(userSettingModel.userRole, KTestText.userSettingModel.userRole);
        expect(
          userSettingModel.roleIsConfirmed,
          KTestText.userSettingModel.roleIsConfirmed,
        );
        expect(
          userSettingModel.timeSendingFeedback,
          KTestText.userSettingModel.timeSendingFeedback,
        );
      });
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.userSettingModel.id,
          'locale': _$LanguageEnumMap[KTestText.userSettingModel.locale],
          'roleIsConfirmed': KTestText.userSettingModel.roleIsConfirmed,
        };

        final userSettingModel = UserSetting.fromJson(json);

        expect(userSettingModel.id, KTestText.userSettingModel.id);
        expect(userSettingModel.locale, KTestText.userSettingModel.locale);
        expect(userSettingModel.userRole, isNull);
        expect(
          userSettingModel.roleIsConfirmed,
          KTestText.userSettingModel.roleIsConfirmed,
        );
        expect(userSettingModel.timeSendingFeedback, isNull);
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          // id is missing
          'locale': KTestText.userSettingModel.locale,
          'userRole': KTestText.userSettingModel.userRole,
          'roleIsConfirmed': KTestText.userSettingModel.roleIsConfirmed,
          'timeSendingFeedback':
              KTestText.userSettingModel.timeSendingFeedback?.toIso8601String(),
        };

        expect(
          () => UserSetting.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.userSettingModel.id,
          'locale': _$LanguageEnumMap[KTestText.userSettingModel.locale],
          'userRole': _$UserRoleEnumMap[KTestText.userSettingModel.userRole],
          'roleIsConfirmed': KTestText.userSettingModel.roleIsConfirmed,
          'timeSendingFeedback':
              KTestText.userSettingModel.timeSendingFeedback?.toIso8601String(),
        };

        final userModelJson = KTestText.userSettingModel.toJson();

        expect(userModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.userSettingModel.id,
          'locale': _$LanguageEnumMap[KTestText.userSettingModel.locale],
          'userRole': null,
          'roleIsConfirmed': KTestText.userSettingModel.roleIsConfirmed,
          'timeSendingFeedback': null,
        };

        final userModelJson = KTestText.userSettingModel
            .copyWith(userRole: null, timeSendingFeedback: null)
            .toJson();

        expect(userModelJson, json);
      });
    });
  });
}

const _$LanguageEnumMap = {
  Language.ukrain: 'ukrain',
  Language.english: 'english',
};

const _$UserRoleEnumMap = {
  UserRole.veteran: 'veteran',
  UserRole.relativeOfVeteran: 'relativeOfVeteran',
  UserRole.civilian: 'civilian',
  UserRole.businessmen: 'businessmen',
};

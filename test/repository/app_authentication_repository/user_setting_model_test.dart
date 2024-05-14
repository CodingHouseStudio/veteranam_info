import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.appAuthentication} ${KGroupText.model} User Setting',
      () {
    test('check is Empty ', () {
      expect(
        KTestText.userSetting.isEmpty,
        isFalse,
      );

      expect(
        UserSetting.empty.isEmpty,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestText.userSetting.isNotEmpty,
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
          'id': KTestText.userSetting.id,
          'locale': _$LanguageEnumMap[KTestText.userSetting.locale],
          'userRole': _$UserRoleEnumMap[KTestText.userSetting.userRole],
          'roleIsConfirmed': KTestText.userSetting.roleIsConfirmed,
        };

        final userSetting = UserSetting.fromJson(json);

        expect(userSetting.id, KTestText.userSetting.id);
        expect(userSetting.locale, KTestText.userSetting.locale);
        expect(userSetting.userRole, KTestText.userSetting.userRole);
        expect(
          userSetting.roleIsConfirmed,
          KTestText.userSetting.roleIsConfirmed,
        );
      });
      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.userSetting.id,
          'locale': _$LanguageEnumMap[KTestText.userSetting.locale],
          'roleIsConfirmed': KTestText.userSetting.roleIsConfirmed,
        };

        final userSetting = UserSetting.fromJson(json);

        expect(userSetting.id, KTestText.userSetting.id);
        expect(userSetting.locale, KTestText.userSetting.locale);
        expect(userSetting.userRole, isNull);
        expect(
          userSetting.roleIsConfirmed,
          KTestText.userSetting.roleIsConfirmed,
        );
      });

      test('${KGroupText.shouldNotBe} ', () {
        final json = {
          // id is missing
          'locale': KTestText.userSetting.locale,
          'userRole': KTestText.userSetting.userRole,
          'roleIsConfirmed': KTestText.userSetting.roleIsConfirmed,
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
          'id': KTestText.userSetting.id,
          'locale': _$LanguageEnumMap[KTestText.userSetting.locale],
          'userRole': _$UserRoleEnumMap[KTestText.userSetting.userRole],
          'roleIsConfirmed': KTestText.userSetting.roleIsConfirmed,
        };

        final userModelJson = KTestText.userSetting.toJson();

        expect(userModelJson, json);
      });

      test('${KGroupText.shouldBe} ', () {
        final json = {
          'id': KTestText.userSetting.id,
          'locale': _$LanguageEnumMap[KTestText.userSetting.locale],
          'userRole': null,
          'roleIsConfirmed': KTestText.userSetting.roleIsConfirmed,
        };

        final userModelJson =
            KTestText.userSetting.copyWith(userRole: null).toJson();

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

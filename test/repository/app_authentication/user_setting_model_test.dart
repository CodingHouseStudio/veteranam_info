import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.authentication}'
      ' ${KGroupText.model} User Setting', () {
    test('check is Empty ', () {
      expect(
        KTestText.userSettingModel.isEmpty,
        isFalse,
      );

      expect(KTestText.userSettingModel.isDeviceEmpty, isFalse);

      expect(
        UserSetting.empty.isEmpty,
        isTrue,
      );

      expect(UserSetting.empty.isDeviceEmpty, isTrue);

      expect(UserSetting.empty.copyWith(devicesInfo: []).isDeviceEmpty, isTrue);

      expect(
        UserSetting.empty.copyWith(
          devicesInfo: [
            KTestText.deviceInfoModel.copyWith(fcmToken: ''),
          ],
        ).isDeviceEmpty,
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
    final fullJson = {
      UserSettingModelJsonField.id: KTestText.userSettingModel.id,
      UserSettingModelJsonField.locale:
          _$LanguageEnumMap[KTestText.userSettingModel.locale],
      UserSettingModelJsonField.userRole:
          _$UserRoleEnumMap[KTestText.userSettingModel.userRole],
      UserSettingModelJsonField.roleIsConfirmed:
          KTestText.userSettingModel.roleIsConfirmed,
      UserSettingModelJsonField.devicesInfo: [
        KTestText.userSettingModel.devicesInfo!.first.toJson(),
      ],
      UserSettingModelJsonField.nickname: KTestText.nicknameCorrect,
    };
    final nullableJson = {
      UserSettingModelJsonField.id: KTestText.userSettingModel.id,
      UserSettingModelJsonField.locale:
          _$LanguageEnumMap[KTestText.userSettingModel.locale],
      UserSettingModelJsonField.userRole: null,
      UserSettingModelJsonField.roleIsConfirmed:
          KTestText.userSettingModel.roleIsConfirmed,
      UserSettingModelJsonField.devicesInfo: null,
      UserSettingModelJsonField.nickname: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final userSettingModel = UserSetting.fromJson(fullJson);

        expect(userSettingModel.id, KTestText.userSettingModel.id);
        expect(userSettingModel.locale, KTestText.userSettingModel.locale);
        expect(userSettingModel.userRole, KTestText.userSettingModel.userRole);
        expect(
          userSettingModel.roleIsConfirmed,
          KTestText.userSettingModel.roleIsConfirmed,
        );
        expect(
          userSettingModel.devicesInfo,
          KTestText.userSettingModel.devicesInfo,
        );
        expect(
          userSettingModel.nickname,
          KTestText.nicknameCorrect,
        );
      });
      test('${KGroupText.nullable} ', () {
        final userSettingModel = UserSetting.fromJson(nullableJson);

        expect(userSettingModel.id, KTestText.userSettingModel.id);
        expect(userSettingModel.locale, KTestText.userSettingModel.locale);
        expect(userSettingModel.userRole, isNull);
        expect(
          userSettingModel.roleIsConfirmed,
          KTestText.userSettingModel.roleIsConfirmed,
        );
        expect(userSettingModel.devicesInfo, isNull);
        expect(
          userSettingModel.nickname,
          isNull,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          UserSettingModelJsonField.locale: KTestText.userSettingModel.locale,
          UserSettingModelJsonField.userRole:
              KTestText.userSettingModel.userRole,
          UserSettingModelJsonField.roleIsConfirmed:
              KTestText.userSettingModel.roleIsConfirmed,
          UserSettingModelJsonField.devicesInfo:
              KTestText.userSettingModel.devicesInfo,
          UserSettingModelJsonField.nickname: KTestText.nicknameCorrect,
        };

        expect(
          () => UserSetting.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final userModelJson = KTestText.userSettingModel.toJson();

        expect(userModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final userModelJson = KTestText.userSettingModel
            .copyWith(
              userRole: null,
              devicesInfo: null,
              nickname: null,
            )
            .toJson();

        expect(userModelJson, nullableJson);
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

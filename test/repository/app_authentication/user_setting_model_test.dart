import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group(
      '${KScreenBlocName.appRepository} ${KScreenBlocName.authentication}'
      ' ${KGroupText.model} User Setting', () {
    test('check is Empty ', () {
      expect(
        KTestVariables.userSettingModel.isEmpty,
        isFalse,
      );

      expect(KTestVariables.userSettingModel.isDeviceEmpty, isFalse);

      expect(
        UserSetting.empty.isEmpty,
        isTrue,
      );

      expect(UserSetting.empty.isDeviceEmpty, isTrue);

      expect(UserSetting.empty.copyWith(devicesInfo: []).isDeviceEmpty, isTrue);

      expect(
        UserSetting.empty.copyWith(
          devicesInfo: [
            KTestVariables.deviceInfoModel.copyWith(fcmToken: ''),
          ],
        ).isDeviceEmpty,
        isTrue,
      );
    });
    test('check is not Empty ', () {
      expect(
        KTestVariables.userSettingModel.isNotEmpty,
        isTrue,
      );

      expect(
        UserSetting.empty.isNotEmpty,
        isFalse,
      );
    });
    test('Get frp, ', () {
      expect(
        Language.getFromLanguageCode('uk'),
        Language.ukraine,
      );

      expect(
        Language.getFromLanguageCode('en'),
        Language.english,
      );

      expect(
        Language.getFromLanguageCode(KTestVariables.field),
        Language.ukraine,
      );
    });
    final fullJson = {
      UserSettingModelJsonField.id: KTestVariables.userSettingModel.id,
      UserSettingModelJsonField.locale:
          _$LanguageEnumMap[KTestVariables.userSettingModel.locale],
      UserSettingModelJsonField.userRole:
          _$UserRoleEnumMap[KTestVariables.userSettingModel.userRole],
      UserSettingModelJsonField.roleIsConfirmed:
          KTestVariables.userSettingModel.roleIsConfirmed,
      UserSettingModelJsonField.devicesInfo: [
        KTestVariables.userSettingModel.devicesInfo!.first.toJson(),
      ],
      UserSettingModelJsonField.nickname: KTestVariables.nicknameCorrect,
      UserSettingModelJsonField.deletedOn:
          KTestVariables.dateTime.toIso8601String(),
    };
    final nullableJson = {
      UserSettingModelJsonField.id: KTestVariables.userSettingModel.id,
      UserSettingModelJsonField.locale:
          _$LanguageEnumMap[KTestVariables.userSettingModel.locale],
      UserSettingModelJsonField.userRole: null,
      UserSettingModelJsonField.roleIsConfirmed:
          KTestVariables.userSettingModel.roleIsConfirmed,
      UserSettingModelJsonField.devicesInfo: null,
      UserSettingModelJsonField.nickname: null,
      UserSettingModelJsonField.deletedOn: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final userSettingModel = UserSetting.fromJson(fullJson);

        expect(userSettingModel.id, KTestVariables.userSettingModel.id);
        expect(userSettingModel.locale, KTestVariables.userSettingModel.locale);
        expect(
          userSettingModel.userRole,
          KTestVariables.userSettingModel.userRole,
        );
        expect(
          userSettingModel.roleIsConfirmed,
          KTestVariables.userSettingModel.roleIsConfirmed,
        );
        expect(
          userSettingModel.devicesInfo,
          KTestVariables.userSettingModel.devicesInfo,
        );
        expect(
          userSettingModel.nickname,
          KTestVariables.nicknameCorrect,
        );
        expect(
          userSettingModel.deletedOn,
          KTestVariables.dateTime,
        );
      });
      test('${KGroupText.nullable} ', () {
        final userSettingModel = UserSetting.fromJson(nullableJson);

        expect(userSettingModel.id, KTestVariables.userSettingModel.id);
        expect(userSettingModel.locale, KTestVariables.userSettingModel.locale);
        expect(userSettingModel.userRole, isNull);
        expect(
          userSettingModel.roleIsConfirmed,
          KTestVariables.userSettingModel.roleIsConfirmed,
        );
        expect(userSettingModel.devicesInfo, isNull);
        expect(
          userSettingModel.nickname,
          isNull,
        );
        expect(
          userSettingModel.deletedOn,
          isNull,
        );
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // id is missing
          UserSettingModelJsonField.locale:
              KTestVariables.userSettingModel.locale,
          UserSettingModelJsonField.userRole:
              KTestVariables.userSettingModel.userRole,
          UserSettingModelJsonField.roleIsConfirmed:
              KTestVariables.userSettingModel.roleIsConfirmed,
          UserSettingModelJsonField.devicesInfo:
              KTestVariables.userSettingModel.devicesInfo,
          UserSettingModelJsonField.nickname: KTestVariables.nicknameCorrect,
        };

        expect(
          () => UserSetting.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final userModelJson = KTestVariables.userSettingModel
            .copyWith(
              deletedOn: KTestVariables.dateTime,
            )
            .toJson();

        expect(userModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final userModelJson = KTestVariables.userSettingModel
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
  Language.ukraine: 'ukrain',
  Language.english: 'english',
};

const _$UserRoleEnumMap = {
  UserRole.veteran: 'veteran',
  UserRole.relativeOfVeteran: 'relativeOfVeteran',
  UserRole.civilian: 'civilian',
  UserRole.businessmen: 'businessmen',
};

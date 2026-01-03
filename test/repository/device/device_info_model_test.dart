import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/constants/enum.dart';
import 'package:veteranam/shared/models/models.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group(
      '${KScreenBlocName.device} info ${KGroupText.model} ${KGroupText.model}',
      () {
    test('check is Empty ', () {
      expect(
        KTestVariables.deviceInfoModel.isEmpty,
        isFalse,
      );

      expect(
        KTestVariables.deviceInfoModel.copyWith(fcmToken: null).isEmpty,
        isTrue,
      );
    });
    test('Platform check ', () {
      expect(
        PlatformEnum.android.isAndroid,
        isTrue,
      );
      expect(
        PlatformEnum.web.isWeb,
        isTrue,
      );
      expect(
        PlatformEnum.ios.isIOS,
        isTrue,
      );
      expect(
        PlatformEnum.unknown.isUnkown,
        isTrue,
      );

      expect(
        PlatformEnum.ios.isAndroid,
        isFalse,
      );
      expect(
        PlatformEnum.android.isIOS,
        isFalse,
      );
      expect(
        PlatformEnum.web.isUnkown,
        isFalse,
      );
      expect(
        PlatformEnum.unknown.isWeb,
        isFalse,
      );
    });
    final fullJson = {
      DeviceInfoModelJsonField.deviceId:
          KTestVariables.deviceInfoModel.deviceId,
      DeviceInfoModelJsonField.build: KTestVariables.deviceInfoModel.build,
      DeviceInfoModelJsonField.date:
          KTestVariables.deviceInfoModel.date.toIso8601String(),
      DeviceInfoModelJsonField.platform:
          _$PlatformEnumEnumMap[KTestVariables.deviceInfoModel.platform],
      DeviceInfoModelJsonField.fcmToken:
          KTestVariables.deviceInfoModel.fcmToken,
    };
    final nullableJson = {
      DeviceInfoModelJsonField.deviceId:
          KTestVariables.deviceInfoModel.deviceId,
      DeviceInfoModelJsonField.build: KTestVariables.deviceInfoModel.build,
      DeviceInfoModelJsonField.date:
          KTestVariables.deviceInfoModel.date.toIso8601String(),
      DeviceInfoModelJsonField.platform:
          _$PlatformEnumEnumMap[KTestVariables.deviceInfoModel.platform],
      DeviceInfoModelJsonField.fcmToken: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final deviceInfo = DeviceInfoModel.fromJson(fullJson);

        expect(deviceInfo.deviceId, KTestVariables.deviceInfoModel.deviceId);
        expect(deviceInfo.build, KTestVariables.deviceInfoModel.build);
        expect(deviceInfo.date, KTestVariables.deviceInfoModel.date);
        expect(deviceInfo.fcmToken, KTestVariables.deviceInfoModel.fcmToken);
        expect(deviceInfo.platform, KTestVariables.deviceInfoModel.platform);
      });
      test('${KGroupText.nullable} ', () {
        final deviceInfo = DeviceInfoModel.fromJson(nullableJson);

        expect(deviceInfo.deviceId, KTestVariables.deviceInfoModel.deviceId);
        expect(deviceInfo.build, KTestVariables.deviceInfoModel.build);
        expect(deviceInfo.date, KTestVariables.deviceInfoModel.date);
        expect(deviceInfo.platform, KTestVariables.deviceInfoModel.platform);
        expect(deviceInfo.fcmToken, isNull);
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // deviceId is missing
          DeviceInfoModelJsonField.build: KTestVariables.deviceInfoModel.build,
          DeviceInfoModelJsonField.date: KTestVariables.deviceInfoModel.date,
          DeviceInfoModelJsonField.platform:
              _$PlatformEnumEnumMap[KTestVariables.deviceInfoModel.platform],
          DeviceInfoModelJsonField.fcmToken:
              KTestVariables.deviceInfoModel.fcmToken,
        };

        expect(
          () => DeviceInfoModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final deviceInfoModelJson = KTestVariables.deviceInfoModel.toJson();

        expect(deviceInfoModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final deviceInfoModelJson =
            KTestVariables.deviceInfoModel.copyWith(fcmToken: null).toJson();

        expect(deviceInfoModelJson, nullableJson);
      });
    });
  });
}

const _$PlatformEnumEnumMap = {
  PlatformEnum.android: 'android',
  PlatformEnum.ios: 'ios',
  PlatformEnum.web: 'web',
  PlatformEnum.unknown: 'unknown',
};

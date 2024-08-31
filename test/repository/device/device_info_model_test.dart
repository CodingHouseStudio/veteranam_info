import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
  group(
      '${KScreenBlocName.device} info ${KGroupText.model} ${KGroupText.model}',
      () {
    test('check is Empty ', () {
      expect(
        KTestText.deviceInfoModel.isEmpty,
        isFalse,
      );

      expect(
        KTestText.deviceInfoModel.copyWith(fcmToken: null).isEmpty,
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
      DeviceInfoModelJsonField.deviceId: KTestText.deviceInfoModel.deviceId,
      DeviceInfoModelJsonField.build: KTestText.deviceInfoModel.build,
      DeviceInfoModelJsonField.date:
          KTestText.deviceInfoModel.date.toIso8601String(),
      DeviceInfoModelJsonField.platform:
          _$PlatformEnumEnumMap[KTestText.deviceInfoModel.platform],
      DeviceInfoModelJsonField.fcmToken: KTestText.deviceInfoModel.fcmToken,
    };
    final nullableJson = {
      DeviceInfoModelJsonField.deviceId: KTestText.deviceInfoModel.deviceId,
      DeviceInfoModelJsonField.build: KTestText.deviceInfoModel.build,
      DeviceInfoModelJsonField.date:
          KTestText.deviceInfoModel.date.toIso8601String(),
      DeviceInfoModelJsonField.platform:
          _$PlatformEnumEnumMap[KTestText.deviceInfoModel.platform],
      DeviceInfoModelJsonField.fcmToken: null,
    };
    group('${KGroupText.modelJson} ', () {
      test('${KGroupText.full} ', () {
        final deviceInfo = DeviceInfoModel.fromJson(fullJson);

        expect(deviceInfo.deviceId, KTestText.deviceInfoModel.deviceId);
        expect(deviceInfo.build, KTestText.deviceInfoModel.build);
        expect(deviceInfo.date, KTestText.deviceInfoModel.date);
        expect(deviceInfo.fcmToken, KTestText.deviceInfoModel.fcmToken);
        expect(deviceInfo.platform, KTestText.deviceInfoModel.platform);
      });
      test('${KGroupText.nullable} ', () {
        final deviceInfo = DeviceInfoModel.fromJson(nullableJson);

        expect(deviceInfo.deviceId, KTestText.deviceInfoModel.deviceId);
        expect(deviceInfo.build, KTestText.deviceInfoModel.build);
        expect(deviceInfo.date, KTestText.deviceInfoModel.date);
        expect(deviceInfo.platform, KTestText.deviceInfoModel.platform);
        expect(deviceInfo.fcmToken, isNull);
      });

      test('${KGroupText.failure} ', () {
        final json = {
          // deviceId is missing
          DeviceInfoModelJsonField.build: KTestText.deviceInfoModel.build,
          DeviceInfoModelJsonField.date: KTestText.deviceInfoModel.date,
          DeviceInfoModelJsonField.platform:
              _$PlatformEnumEnumMap[KTestText.deviceInfoModel.platform],
          DeviceInfoModelJsonField.fcmToken: KTestText.deviceInfoModel.fcmToken,
        };

        expect(
          () => DeviceInfoModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });
    group('${KGroupText.jsonModel} ', () {
      test('${KGroupText.full} ', () {
        final deviceInfoModelJson = KTestText.deviceInfoModel.toJson();

        expect(deviceInfoModelJson, fullJson);
      });

      test('${KGroupText.nullable} ', () {
        final deviceInfoModelJson =
            KTestText.deviceInfoModel.copyWith(fcmToken: null).toJson();

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

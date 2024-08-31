import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setupFirebaseAuthMocks();

  group('${KScreenBlocName.device} ${KGroupText.repository} ', () {
    final webInfo = WebBrowserInfo.fromMap({
      'appCodeName': 'CODENAME',
      'appName': 'NAME',
      'appVersion': 'VERSION',
      'deviceMemory': 64,
      'language': 'en',
      'languages': ['en', 'es'],
      'platform': KTestText.deviceId,
      'product': 'PRODUCT',
      'productSub': 'PRODUCTSUB',
      'userAgent': KTestText.deviceId,
      'vendor': 'VENDOR',
      'vendorSub': 'VENDORSUB',
      'hardwareConcurrency': 1,
      'maxTouchPoints': 2,
    });
    late IDeviceRepository deviceRepository;
    late FirebaseMessaging mockFirebaseMessaging;
    late DeviceInfoPlugin mockDeviceInfoPlugin;
    late BuildRepository mockBuildRepository;
    setUp(() {
      KTest.testReleaseMode = true;
      ExtendedDateTime.current = KTestText.dateTime;

      mockFirebaseMessaging = MockFirebaseMessaging();
      mockDeviceInfoPlugin = MockDeviceInfoPlugin();
      mockBuildRepository = MockBuildRepository();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockFirebaseMessaging.setAutoInitEnabled(true),
        ).thenAnswer(
          (_) async {},
        );
        when(
          mockFirebaseMessaging.requestPermission(),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings,
        );
        when(
          mockFirebaseMessaging.requestPermission(provisional: true),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings,
        );
        when(mockFirebaseMessaging.getAPNSToken()).thenAnswer(
          (_) async => null,
        );
        when(
          mockFirebaseMessaging.getToken(
            vapidKey: KSecurityKeys.firebaseDevVapidKey,
          ),
        ).thenAnswer(
          (_) async => KTestText.fcmToken,
        );

        when(
          mockBuildRepository.getBuildInfo(),
        ).thenAnswer(
          (_) async => BuildRepository.defaultValue,
        );

        when(
          mockDeviceInfoPlugin.deviceInfo,
        ).thenAnswer(
          (_) async => webInfo,
        );

        deviceRepository = DeviceRepository(
          mockFirebaseMessaging,
          mockDeviceInfoPlugin,
          mockBuildRepository,
        );
      });

      test('Get device', () async {
        expect(
          await deviceRepository.getDevice(),
          isA<Right<SomeFailure, DeviceInfoModel?>>().having(
            (e) => e.value,
            'value',
            KTestText.deviceInfoModel.copyWith(
              deviceId: webInfo.toString(),
              platform: PlatformEnum.unknown,
              build: BuildRepository.defaultValue.buildNumber,
            ),
          ),
        );
      });
      test('Get device whne is not release mode', () async {
        KTest.testReleaseMode = false;
        expect(
          await deviceRepository.getDevice(),
          isA<Right<SomeFailure, DeviceInfoModel?>>().having(
            (e) => e.value,
            'value',
            null,
          ),
        );
      });
      test('Get device when device id exist', () async {
        expect(
          await deviceRepository.getDevice(
            initialList: [
              KTestText.deviceInfoModel.copyWith(
                deviceId: webInfo.toString(),
              ),
            ],
          ),
          isA<Right<SomeFailure, DeviceInfoModel?>>().having(
            (e) => e.value,
            'value',
            null,
          ),
        );
      });
      test('Get device id android', () async {
        await deviceRepository.getDeviceId(
          platformValue: PlatformEnum.android,
        );

        verify(
          mockDeviceInfoPlugin.androidInfo,
        ).called(1);
      });
      test('Get device id ios', () async {
        await deviceRepository.getDeviceId(
          platformValue: PlatformEnum.ios,
        );

        verify(
          mockDeviceInfoPlugin.iosInfo,
        ).called(1);
      });
      test('Get device id web', () async {
        await deviceRepository.getDeviceId(
          platformValue: PlatformEnum.web,
        );

        verify(
          mockDeviceInfoPlugin.webBrowserInfo,
        ).called(1);
      });
      test('Get FCM ios when getAPNSToken null', () async {
        expect(
          await deviceRepository.getFcm(
            platformValue: PlatformEnum.ios,
          ),
          isA<Right<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            null,
          ),
        );
      });
      test('Get FCM ios when getAPNSToken is not null', () async {
        when(mockFirebaseMessaging.getAPNSToken()).thenAnswer(
          (_) async => KTestText.field,
        );
        expect(
          await deviceRepository.getFcm(
            platformValue: PlatformEnum.ios,
          ),
          isA<Right<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            KTestText.fcmToken,
          ),
        );
      });
      test('Get FCM when permission denied', () async {
        when(mockFirebaseMessaging.requestPermission()).thenAnswer(
          (_) async => KTestText.notificationSettingsDenied,
        );
        expect(
          await deviceRepository.getFcm(),
          isA<Right<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            null,
          ),
        );
      });
    });

    group('${KGroupText.failure} ', () {
      setUp(() {
        when(
          mockFirebaseMessaging.setAutoInitEnabled(true),
        ).thenThrow(
          Exception(KGroupText.failure),
        );
        when(
          mockFirebaseMessaging.requestPermission(),
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        when(
          mockDeviceInfoPlugin.deviceInfo,
        ).thenThrow(
          Exception(KGroupText.failure),
        );

        deviceRepository = DeviceRepository(
          mockFirebaseMessaging,
          mockDeviceInfoPlugin,
          mockBuildRepository,
        );
      });
      test('Get device(get device id failure)', () async {
        expect(
          await deviceRepository.getDevice(),
          isA<Left<SomeFailure, DeviceInfoModel?>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Get device(get FCM failure)', () async {
        when(
          mockDeviceInfoPlugin.deviceInfo,
        ).thenAnswer(
          (_) async => webInfo,
        );
        expect(
          await deviceRepository.getDevice(),
          isA<Left<SomeFailure, DeviceInfoModel?>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Get device id', () async {
        expect(
          await deviceRepository.getDeviceId(),
          isA<Left<SomeFailure, String>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
      test('Get FCM', () async {
        expect(
          await deviceRepository.getFcm(),
          isA<Left<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            const SomeFailure.serverError(),
          ),
        );
      });
    });
  });
}

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);

  group('${KScreenBlocName.device} ${KGroupText.repository} ', () {
    final webInfo = WebBrowserInfo.fromMap({
      'appCodeName': 'CODENAME',
      'appName': 'NAME',
      'appVersion': 'VERSION',
      'deviceMemory': 64,
      'language': 'en',
      'languages': ['en', 'es'],
      'platform': null,
      'product': 'PRODUCT',
      'productSub': 'PRODUCTSUB',
      'userAgent': KTestText.deviceId,
      'vendor': 'VENDOR',
      'vendorSub': 'VENDORSUB',
      'hardwareConcurrency': 1,
      'maxTouchPoints': 2,
    });
    const fakeAndroidBuildVersion = <String, dynamic>{
      'sdkInt': 16,
      'baseOS': 'baseOS',
      'previewSdkInt': 30,
      'release': 'release',
      'codename': 'codename',
      'incremental': 'incremental',
      'securityPatch': 'securityPatch',
    };

    const fakeSupportedAbis = <String>['arm64-v8a', 'x86', 'x86_64'];
    const fakeSupported32BitAbis = <String?>['x86 (IA-32)', 'MMX'];
    const fakeSupported64BitAbis = <String?>['x86-64', 'MMX', 'SSSE3'];
    const fakeSystemFeatures = ['FEATURE_AUDIO_PRO', 'FEATURE_AUDIO_OUTPUT'];

    final androidInfo = AndroidDeviceInfo.fromMap(
      <String, dynamic>{
        'id': KTestText.deviceId,
        'host': 'host',
        'tags': 'tags',
        'type': 'type',
        'model': 'model',
        'board': 'board',
        'brand': 'Google',
        'device': 'device',
        'product': 'product',
        'display': 'display',
        'hardware': 'hardware',
        'isPhysicalDevice': true,
        'bootloader': 'bootloader',
        'fingerprint': 'fingerprint',
        'manufacturer': 'manufacturer',
        'supportedAbis': fakeSupportedAbis,
        'systemFeatures': fakeSystemFeatures,
        'version': fakeAndroidBuildVersion,
        'supported64BitAbis': fakeSupported64BitAbis,
        'supported32BitAbis': fakeSupported32BitAbis,
        'serialNumber': 'SERIAL',
        'isLowRamDevice': false,
      },
    );
    late IDeviceRepository deviceRepository;
    late FirebaseMessaging mockFirebaseMessaging;
    late DeviceInfoPlugin mockDeviceInfoPlugin;
    late AppInfoRepository mockBuildRepository;
    setUp(() {
      KTest.testReleaseMode = true;
      ExtendedDateTime.current = KTestText.dateTime;

      mockFirebaseMessaging = MockFirebaseMessaging();
      mockDeviceInfoPlugin = MockDeviceInfoPlugin();
      mockBuildRepository = MockAppInfoRepository();
    });
    group('${KGroupText.successful} ', () {
      setUp(() {
        when(
          mockFirebaseMessaging.requestPermission(),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings(),
        );
        when(
          mockFirebaseMessaging.requestPermission(provisional: true),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings(),
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
          mockFirebaseMessaging.getNotificationSettings(),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings(),
        );

        when(
          mockBuildRepository.getBuildInfo(),
        ).thenAnswer(
          (_) async => AppInfoRepository.defaultValue,
        );

        when(
          mockDeviceInfoPlugin.deviceInfo,
        ).thenAnswer(
          (_) async => webInfo,
        );
        when(
          mockDeviceInfoPlugin.androidInfo,
        ).thenAnswer(
          (_) async => androidInfo,
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
              build: AppInfoRepository.defaultValue.buildNumber,
            ),
          ),
        );
      });

      // test('Get device Not Determined', () async {
      //   when(
      //     mockFirebaseMessaging.getNotificationSettings(),
      //   ).thenAnswer(
      //     (_) async => KTestText.notificationSettingsnotDetermined,
      //   );

      //   expect(
      //     await deviceRepository.getDevice(),
      //     isA<Right<SomeFailure, DeviceInfoModel?>>().having(
      //       (e) => e.value,
      //       'value',
      //       KTestText.deviceInfoModel.copyWith(
      //         deviceId: webInfo.toString(),
      //         platform: PlatformEnum.unknown,
      //         build: AppInfoRepository.defaultValue.buildNumber,
      //         fcmToken: null,
      //       ),
      //     ),
      //   );
      // });

      // test('Get device Notification settings denied and isAndroid', () async
      // {
      //   PlatformEnum.value = PlatformEnum.android;
      //   when(
      //     mockFirebaseMessaging.getNotificationSettings(),
      //   ).thenAnswer(
      //     (_) async => KTestText.notificationSettingsDenied,
      //   );
      //   expect(
      //     await deviceRepository.getDevice(),
      //     isA<Right<SomeFailure, DeviceInfoModel?>>().having(
      //       (e) => e.value,
      //       'value',
      //       KTestText.deviceInfoModel.copyWith(
      //         deviceId: androidInfo.id,
      //         platform: PlatformEnum.android,
      //         build: AppInfoRepository.defaultValue.buildNumber,
      //         fcmToken: null,
      //       ),
      //     ),
      //   );
      // });
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
      test('Get device id web when platform null', () async {
        when(
          mockDeviceInfoPlugin.webBrowserInfo,
        ).thenAnswer(
          (_) async => webInfo,
        );
        await deviceRepository.getDeviceId(
          platformValue: PlatformEnum.web,
        );

        verify(
          mockDeviceInfoPlugin.webBrowserInfo,
        ).called(1);
      });
      // test('Get FCM ios when getAPNSToken null', () async {
      //   expect(
      //     await deviceRepository.getFcm(
      //       platformValue: PlatformEnum.ios,
      //     ),
      //     isA<Right<SomeFailure, String?>>().having(
      //       (e) => e.value,
      //       'value',
      //       null,
      //     ),
      //   );
      // });
      // test('Get FCM ios when getAPNSToken is not null', () async {
      //   when(mockFirebaseMessaging.getAPNSToken()).thenAnswer(
      //     (_) async => KTestText.field,
      //   );
      //   expect(
      //     await deviceRepository.getFcm(
      //       platformValue: PlatformEnum.ios,
      //     ),
      //     isA<Right<SomeFailure, String?>>().having(
      //       (e) => e.value,
      //       'value',
      //       KTestText.fcmToken,
      //     ),
      //   );
      // });
      test('Get FCM when permission Not Determined', () async {
        when(
          mockFirebaseMessaging.getNotificationSettings(),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings(
            authorizationStatus: AuthorizationStatus.notDetermined,
          ),
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
      test(
          'Get FCM when permission Not Determined IOS '
          'and TrackingStatus denied', () async {
        when(
          mockFirebaseMessaging.getNotificationSettings(),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings(
            authorizationStatus: AuthorizationStatus.notDetermined,
          ),
        );
        DeviceRepository.appTrackingTransparency = TrackingStatus.denied;
        expect(
          await deviceRepository.getFcm(platformValue: PlatformEnum.ios),
          isA<Right<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            null,
          ),
        );
      });
      test(
          'Get FCM when permission Not Determined IOS '
          'and TrackingStatus notDetermined', () async {
        when(
          mockFirebaseMessaging.getNotificationSettings(),
        ).thenAnswer(
          (_) async => KTestText.notificationSettings(
            authorizationStatus: AuthorizationStatus.notDetermined,
          ),
        );
        DeviceRepository.appTrackingTransparency = TrackingStatus.notDetermined;
        expect(
          await deviceRepository.getFcm(platformValue: PlatformEnum.ios),
          isA<Right<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            null,
          ),
        );
      });
      test('Get FCM when permission denied', () async {
        when(mockFirebaseMessaging.getNotificationSettings()).thenAnswer(
          (_) async => KTestText.notificationSettings(
            authorizationStatus: AuthorizationStatus.denied,
          ),
        );
        expect(
          await deviceRepository.getFcm(platformValue: PlatformEnum.android),
          isA<Right<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            null,
          ),
        );
      });
      test('Get FCM when permission provisional', () async {
        when(mockFirebaseMessaging.getNotificationSettings()).thenAnswer(
          (_) async => KTestText.notificationSettings(
            authorizationStatus: AuthorizationStatus.provisional,
          ),
        );
        expect(
          await deviceRepository.getFcm(platformValue: PlatformEnum.ios),
          isA<Right<SomeFailure, String?>>().having(
            (e) => e.value,
            'value',
            KTestText.fcmToken,
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
          isA<Left<SomeFailure, DeviceInfoModel?>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
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
          isA<Left<SomeFailure, DeviceInfoModel?>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Get device id', () async {
        expect(
          await deviceRepository.getDeviceId(),
          isA<Left<SomeFailure, String>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
      test('Get FCM', () async {
        expect(
          await deviceRepository.getFcm(), isA<Left<SomeFailure, String?>>(),
          // .having(
          //   (e) => e.value,
          //   'value',
          //   SomeFailure.serverError(error: null),
          // ),
        );
      });
    });
  });
}

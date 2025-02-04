import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/repositories/app_layout_repository.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

  group('${KScreenBlocName.user} ${KGroupText.repository} ', () {
    late IAppLayoutRepository appLayoutRepository;
    late TestWidgetsFlutterBinding testWidgetsFlutterBinding;

    setUpAll(() {
      testWidgetsFlutterBinding = TestWidgetsFlutterBinding.ensureInitialized();
      // AppLayoutRepository.widgetsBinding = testWidgetsFlutterBinding;
      appLayoutRepository = AppLayoutRepository();
    });

    // ignore: avoid_void_async
    void changeScreenSizeTest(Size size) async {
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(milliseconds: 1));

      testWidgetsFlutterBinding.platformDispatcher.views.first.physicalSize =
          size *
              testWidgetsFlutterBinding
                  .platformDispatcher.views.first.devicePixelRatio;
    }

    test('Init App Version And Change Size in Stream', () async {
      testWidgetsFlutterBinding
          .platformDispatcher.views.first.devicePixelRatio = 3.00;

      testWidgetsFlutterBinding.platformDispatcher.views.first.physicalSize =
          KTestConstants.windowDefaultSize * 3;

      expect(
        appLayoutRepository.getCurrentAppVersion,
        AppVersionEnum.tablet,
      );

      changeScreenSizeTest(KTestConstants.windowDeskSize);

      await expectLater(
        appLayoutRepository.appVersionStream,
        emitsInOrder([
          AppVersionEnum.desk,
        ]),
      );

      changeScreenSizeTest(KTestConstants.windowMobileSize);

      await expectLater(
        appLayoutRepository.appVersionStream,
        emitsInOrder([
          AppVersionEnum.mobile,
        ]),
      );

      changeScreenSizeTest(KTestConstants.windowMobileSize);
      changeScreenSizeTest(KTestConstants.windowDeskSize);

      await expectLater(
        appLayoutRepository.appVersionStream,
        emitsInOrder([
          AppVersionEnum.mobile,
          AppVersionEnum.desk,
        ]),
      );
    });

    tearDown(() => appLayoutRepository.dispose());
  });
}

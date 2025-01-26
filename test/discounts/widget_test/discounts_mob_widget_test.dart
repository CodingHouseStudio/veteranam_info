import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/config/discount_config_cubit.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.discount} ${KScreenBlocName.mobile}', () {
    setUp(() {
      Config.testIsWeb = false;
      PlatformEnumFlutter.isWebDesktop = true;
      Config.isReleaseMode = true;
      Config.falvourValue = Config.production;
      discountsWidgetTestRegister();

      when(
        mockDiscountRepository.getDiscountItems(
          showOnlyBusinessDiscounts: false,
          // reportIdItems: KTestVariables.reportItems.getIdCard,
        ),
      ).thenAnswer(
        (invocation) => Stream.value(KTestVariables.discountModelItemsModify),
      );
      when(
        mockFirebaseRemoteConfigProvider
            .getString(AppVersionCubit.mobAppVersionKey),
      ).thenAnswer(
        (_) => AppInfoRepository.defaultValue.buildNumber,
      );

      when(mockBuildRepository.getBuildInfo()).thenAnswer(
        (invocation) async => AppInfoRepository.defaultValue,
      );
      when(
        mockFirebaseRemoteConfigProvider
            .getBool(DiscountConfigCubit.mobFilterEnhancedMobileKey),
      ).thenAnswer(
        (invocation) => false,
      );
    });
    testWidgets('${KGroupText.initial} ', (tester) async {
      await discountsPumpAppHelper(
        tester,
      );

      await discountsInitialHelper(tester);
    });

    testWidgets('${KGroupText.offlineNetwork} ', (tester) async {
      await networkMobHelper(
        tester: tester,
        pumpApp: () async => discountsPumpAppHelper(
          tester,
        ),
      );
    });

    group('${KGroupText.goRouter} ', () {
      late MockGoRouter mockGoRouter;
      setUp(() => mockGoRouter = MockGoRouter());
      testWidgets('${KGroupText.initial} ', (tester) async {
        await discountsPumpAppHelper(
          tester,
          mockGoRouter: mockGoRouter,
        );

        await discountsInitialHelper(tester);
      });
      group('Open Update dialog', () {
        setUp(() {
          PlatformEnumFlutter.isWebDesktop = false;

          when(mockFirebaseRemoteConfigProvider.waitActivated()).thenAnswer(
            (invocation) async {
              await KTestConstants.delay;
              return true;
            },
          );
          when(
            mockFirebaseRemoteConfigProvider
                .getString(AppVersionCubit.mobAppVersionKey),
          ).thenAnswer(
            (_) => KTestVariables.build,
          );
        });
        testWidgets('Close', (tester) async {
          await discountsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await mobUpdateDialogCloseButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
        testWidgets('Apply', (tester) async {
          await discountsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await mobUpdateDialogApplyButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
      group('${KGroupText.goTo} ', () {
        testWidgets('bottom navigations ', (tester) async {
          await discountsPumpAppHelper(
            tester,
            mockGoRouter: mockGoRouter,
          );

          await mobNavigationButtonsHelper(
            tester: tester,
            mockGoRouter: mockGoRouter,
          );
        });
      });
    });
  });
}

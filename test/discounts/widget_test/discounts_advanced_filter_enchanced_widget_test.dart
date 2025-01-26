import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/components/discounts/bloc/config/discount_config_cubit.dart';
import 'package:veteranam/shared/extension/extension_flutter_constants.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';
import '../helper/helper.dart';

void main() {
  setUp(configureDependenciesTest);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDown(GetIt.I.reset);
  group('${KScreenBlocName.discount} ', () {
    void setUpTest() {
      // KTest.animatioRepeat=1;
      ExtendedDateTime.id = KTestVariables.id;
      ExtendedDateTime.current = KTestVariables.dateTime;
      PlatformEnumFlutter.isWebDesktop = true;
      discountsWidgetTestRegister();

      when(mockBuildRepository.getBuildInfo()).thenAnswer(
        (invocation) async => AppInfoRepository.defaultValue,
      );
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
            .getBool(DiscountConfigCubit.mobFilterEnhancedMobileKey),
      ).thenAnswer(
        (invocation) => true,
      );
    }

    group('Adnvanced Filter Enhanced for mob', () {
      setUp(setUpTest);
      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await advancedFilterEnchancedMobileHelper(tester);
      });
    });

    group('Adnvanced Filter Enhanced for mob(cities)', () {
      setUp(setUpTest);
      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await advancedFilterEnchancedMobileCityHelper(tester);
      });
    });
  });
}

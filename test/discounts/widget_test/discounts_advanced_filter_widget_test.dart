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
  setUpAll(configureDependenciesTest);

  setUp(resetTestVariables);

  setUpAll(setUpGlobal);

  setupFirebaseAuthMocks();

  tearDownAll(GetIt.I.reset);

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
        (invocation) => false,
      );
    }

    group('Advanced filter reset mobile', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await advancedFilterResetMobHelper(
          tester,
        );
      });
    });
    group('Advanced Filter Applied', () {
      setUp(setUpTest);
      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await advancedFilterAppliedHelper(tester);
      });
    });
    group('Advanced Filter Open Confirms Dialog', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await advancedFilterMobLocationTopTapHelper(tester);
      });
    });

    group('Advanced Filter Close Open Items Helper', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await advancedFilterCloseOpenItemsHelper(tester);
      });
    });

    group('Advanced Filter Close Open Cities Items Helper', () {
      setUp(setUpTest);

      testWidgets('Widget Test', (tester) async {
        await discountsPumpAppHelper(
          tester,
        );

        await advancedFilterCloseOpenItemsHelper(tester);
      });
    });
  });
}

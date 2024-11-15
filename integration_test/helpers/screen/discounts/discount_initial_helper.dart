import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> discountsInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.discounts.screen), findsOneWidget);

  if (!Config.isWeb) {
    expect(
      find.byKey(KWidgetkeys.widget.nawbar.pageName),
      findsOneWidget,
    );
    //   expect(
    //     find.byKey(KWidgetkeys.screen.discounts.titlePoint),
    //     findsOneWidget,
    //   );
    // } else {
    await mobNavigationHelper(tester);
  } else {
    expect(
      find.byKey(KWidgetkeys.screen.discounts.title),
      findsOneWidget,
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.discounts.filter),
    findsOneWidget,
  );

  await filterChipHelper(tester);

  if (Config.isDevelopment) {
    expect(
      find.byKey(KWidgetkeys.screen.discounts.addDiscountButton),
      findsOneWidget,
    );
  }

  await advancedFilterHelper(tester);

  expect(
    find.byKey(KWidgetkeys.screen.discounts.card),
    findsWidgets,
  );

  await discountCardHelper(tester);

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.discounts.card,
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.discounts.buttonMock),
  //   findsNothing,
  // );
}

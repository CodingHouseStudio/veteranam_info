import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> discountsInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(DiscountsKeys.screen), findsOneWidget);

  if (!Config.isWeb) {
    expect(
      find.byKey(NawbarKeys.pageName),
      findsOneWidget,
    );
    //   expect(
    //     find.byKey(DiscountsKeys.titlePoint),
    //     findsOneWidget,
    //   );
    // } else {
    await mobNavigationHelper(tester);
  } else {
    expect(
      find.byKey(DiscountsKeys.title),
      findsOneWidget,
    );
  }

  expect(
    find.byKey(DiscountsKeys.filter),
    findsOneWidget,
  );

  await filterChipHelper(tester);

  if (Config.isDevelopment) {
    expect(
      find.byKey(DiscountsKeys.addDiscountButton),
      findsOneWidget,
    );
  }

  await advancedFilterHelper(tester);

  expect(
    find.byKey(DiscountsKeys.card),
    findsWidgets,
  );

  await discountCardHelper(tester);

  await scrollingHelperInt(
    tester: tester,
    itemKey: DiscountsKeys.card,
  );

  // expect(
  //   find.byKey(DiscountsKeys.buttonMock),
  //   findsNothing,
  // );
}

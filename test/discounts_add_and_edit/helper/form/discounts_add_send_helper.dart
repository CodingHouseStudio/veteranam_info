import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> discountsAddSendHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: DiscountsAddKeys.sendButton,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(DiscountsAddKeys.sendButton),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(DiscountsAddKeys.sendButton),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  // await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);
}

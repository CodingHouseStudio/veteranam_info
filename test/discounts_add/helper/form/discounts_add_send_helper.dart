import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> discountsAddSendHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.discountsAdd.sendButton,
    offset: KTestConstants.scrollingDown,
  );

  expect(
    find.byKey(KWidgetkeys.screen.discountsAdd.sendButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.discountsAdd.sendButton));

  await tester.pumpAndSettle();

  await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);
}
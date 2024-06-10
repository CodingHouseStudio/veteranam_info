import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> mockButtonHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.feedbackTitle,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.leftImages,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.fundsPoint,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.card),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.buttonMock,
  );

  expect(
    find.byKey(KWidgetkeys.screen.investors.buttonMock),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.investors.buttonMock));
}

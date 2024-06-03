import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> mockButtonHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.information.card),
    findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.information.buttonMock,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.buttonMock),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.information.buttonMock));
}

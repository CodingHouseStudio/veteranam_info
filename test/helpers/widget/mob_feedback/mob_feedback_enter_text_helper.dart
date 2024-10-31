import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> mobFeedbackEnterTextHelper({
  required WidgetTester tester,
  required String text,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.title),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.mobFeedback.title),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle(const Duration(seconds: 15));

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.field),
    findsOneWidget,
  );

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.mobFeedback.field),
    text,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.button),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.mobFeedback.button,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.mobFeedback.button),
    // warnIfMissed: false,
  );

  await tester.pumpAndSettle(
    const Duration(
      seconds: 10,
    ),
  );
}

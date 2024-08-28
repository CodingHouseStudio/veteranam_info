import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> mobFeedbackHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.text),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.icon),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.mobFeedback.icon),
    warnIfMissed: false,
  );

  await tester.pumpAndSettle(const Duration(seconds: 15));

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.field),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.button),
    findsOneWidget,
  );
}

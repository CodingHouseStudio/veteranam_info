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

  await tester.longPress(find.byKey(KWidgetkeys.widget.mobFeedback.icon));

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

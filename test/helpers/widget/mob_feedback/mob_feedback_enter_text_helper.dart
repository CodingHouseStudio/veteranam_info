import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> mobFeedbackEnterTextHelper({
  required WidgetTester tester,
  required String text,
}) async {
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

  await tester.tap(find.byKey(KWidgetkeys.widget.mobFeedback.button));

  await tester.pumpAndSettle();
}

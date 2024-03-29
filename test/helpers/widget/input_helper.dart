import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> inputHelper({
  required WidgetTester tester,
  required String message,
}) async {
  expect(find.byKey(KWidgetkeys.inputKeys.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.inputKeys.icon), findsOneWidget);

  await tester.enterText(find.byKey(KWidgetkeys.inputKeys.field), message);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.inputKeys.field),
      matching: find.text(message),
    ),
    findsOneWidget,
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> messageFieldHelper({
  required WidgetTester tester,
  required String message,
}) async {
  expect(find.byKey(KWidgetkeys.widgetKeys.inputKeys.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widgetKeys.inputKeys.icon), findsOneWidget);

  await tester.enterText(
    find.byKey(KWidgetkeys.widgetKeys.inputKeys.field),
    message,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.inputKeys.field),
      matching: find.text(message),
    ),
    findsOneWidget,
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> messageFieldHelper({
  required WidgetTester tester,
  required String message,
}) async {
  expect(find.byKey(KWidgetkeys.widget.messageField.widget), findsOneWidget);

  // expect(find.byKey(KWidgetkeys.widget.messageField.icon), findsOneWidget);

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.messageField.widget),
    message,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.messageField.widget),
      matching: find.text(message),
    ),
    findsOneWidget,
  );
}

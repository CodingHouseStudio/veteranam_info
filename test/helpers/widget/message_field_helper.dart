import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> messageFieldHelper({
  required WidgetTester tester,
  required String message,
}) async {
  expect(find.byKey(KWidgetkeys.widget.input.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.input.icon), findsOneWidget);

  await tester.enterText(
    find.byKey(KWidgetkeys.widget.input.field),
    message,
  );

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.input.field),
      matching: find.text(message),
    ),
    findsOneWidget,
  );
}

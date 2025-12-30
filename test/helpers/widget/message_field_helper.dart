import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> messageFieldHelper({
  required WidgetTester tester,
  required String message,
}) async {
  expect(find.byKey(MessageFieldKeys.widget), findsOneWidget);

  // expect(find.byKey(MessageFieldKeys.icon), findsOneWidget);

  await tester.enterText(
    find.byKey(MessageFieldKeys.widget),
    message,
  );

  expect(
    find.descendant(
      of: find.byKey(MessageFieldKeys.widget),
      matching: find.text(message),
    ),
    findsOneWidget,
  );
}

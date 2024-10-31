import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> mobFeedbackHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.field),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobFeedback.button),
    findsOneWidget,
  );
}

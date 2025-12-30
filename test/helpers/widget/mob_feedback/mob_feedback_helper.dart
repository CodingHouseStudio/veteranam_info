import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> mobFeedbackHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(MobFeedbackKeys.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(MobFeedbackKeys.title),
    findsOneWidget,
  );

  expect(
    find.byKey(MobFeedbackKeys.messageField),
    findsOneWidget,
  );

  expect(
    find.byKey(MobFeedbackKeys.emailField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: MobFeedbackKeys.emailField,
  );

  expect(
    find.byKey(MobFeedbackKeys.button),
    findsOneWidget,
  );
}

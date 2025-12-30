import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> feedbackFormInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(FeedbackKeys.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(FeedbackKeys.nameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: FeedbackKeys.nameField,
  );

  // expect(
  //   find.byKey(FeedbackKeys.emailButton),
  //   findsOneWidget,
  // );

  await emailButtonHelper(tester);

  expect(
    find.byKey(FeedbackKeys.messageField),
    findsOneWidget,
  );

  expect(
    find.byKey(FeedbackKeys.buttonText),
    findsOneWidget,
  );

  expect(find.byKey(FeedbackKeys.button), findsOneWidget);

  await doubleButtonHelper(tester);

  expect(
    find.byKey(FeedbackKeys.emailText),
    findsOneWidget,
  );

  expect(
    find.byKey(FeedbackKeys.emailButton),
    findsOneWidget,
  );

  expect(
    find.byKey(FeedbackKeys.socialText),
    findsOneWidget,
  );

  expect(
    find.byKey(FeedbackKeys.linkedIn),
    findsOneWidget,
  );

  expect(
    find.byKey(FeedbackKeys.instagram),
    findsOneWidget,
  );

  expect(
    find.byKey(FeedbackKeys.facebook),
    findsOneWidget,
  );

  await feedbackBoxHelper(tester: tester, exist: false);
}

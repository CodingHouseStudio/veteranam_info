import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> feedbackFormInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.feedback.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.nameField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.feedback.nameField,
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.feedback.emailButton),
  //   findsOneWidget,
  // );

  await emailButtonHelper(tester);

  expect(
    find.byKey(KWidgetkeys.screen.feedback.messageField),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.buttonText),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.screen.feedback.button), findsOneWidget);

  await doubleButtonHelper(tester);

  expect(
    find.byKey(KWidgetkeys.screen.feedback.emailText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.emailButton),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.socialText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.linkedIn),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.instagram),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.facebook),
    findsOneWidget,
  );

  await feedbackBoxHelper(tester: tester, exist: false);
}

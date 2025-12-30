import 'package:flutter/widgets.dart' show ScrollPositionAlignmentPolicy;

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> footerFeedbackHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  if (find.byKey(FooterKeys.button).evaluate().isEmpty) {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );
  }

  if (find.byKey(FooterKeys.button).evaluate().isEmpty) {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingUp500,
      itemKey: FooterKeys.title,
    );
  }

  expect(
    find.byKey(FooterKeys.button),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.button,
    scrollPositionAlignmentPolicy:
        ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp150,
  );

  await tester.tap(find.byKey(FooterKeys.button));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.feedback.name,
    ),
  ).called(1);
}

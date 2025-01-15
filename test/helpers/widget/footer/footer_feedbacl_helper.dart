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

  expect(
    find.byKey(FooterKeys.button),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.button,
  );

  await tester.tap(find.byKey(FooterKeys.button));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.feedback.name,
    ),
  ).called(1);
}

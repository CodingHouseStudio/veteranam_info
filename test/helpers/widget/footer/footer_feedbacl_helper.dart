import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

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
    find.byKey(KWidgetkeys.widget.footer.button),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.footer.button));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.feedback.name,
    ),
  ).called(1);
}

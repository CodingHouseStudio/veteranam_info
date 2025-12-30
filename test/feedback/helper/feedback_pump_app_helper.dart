import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/feedback/view/feedback_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> feedbackPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const FeedbackScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(FeedbackKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

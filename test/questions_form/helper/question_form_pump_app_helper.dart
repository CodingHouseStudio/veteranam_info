import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/questions_form/view/questions_form_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> questionFormPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const QuestionsFormScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(QuestionsFormKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();

  await tester.pumpAndSettle();
}

import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/thanks/view/thanks_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> thanksPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const ThanksScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(ThanksKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

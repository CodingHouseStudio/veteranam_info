import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/investors/view/investors_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> investorsPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const InvestorsScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(InvestorsKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

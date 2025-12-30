import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/components/information/view/information_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> informationPumpAppHelper(
  WidgetTester tester, {
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const InformationScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(InformationKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

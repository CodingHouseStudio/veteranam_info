import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/components/work/view/work_view.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> workPumpAppHelper({
  required WidgetTester tester,
  MockGoRouter? mockGoRouter,
}) async {
  await tester.pumpApp(const WorkScreen(), mockGoRouter: mockGoRouter);

  expect(
    find.byKey(WorkKeys.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();
}

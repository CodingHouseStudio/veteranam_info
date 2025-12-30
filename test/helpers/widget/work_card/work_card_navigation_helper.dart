import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> workCardNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(WorkCardKeys.button),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: WorkCardKeys.button,
  );

  await tester.tap(
    find.byKey(WorkCardKeys.button).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  verify(() => mockGoRouter.goNamed(KRoute.employeeRespond.name)).called(1);
}

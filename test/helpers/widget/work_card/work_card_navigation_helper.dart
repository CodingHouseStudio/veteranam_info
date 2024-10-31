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
    find.byKey(KWidgetkeys.widget.workCard.button),
    findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.workCard.button,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.workCard.button).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();

  verify(() => mockGoRouter.goNamed(KRoute.employeeRespond.name)).called(1);
}

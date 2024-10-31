import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> workEmployeeInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.subtitle),
        findsOneWidget,
      );

      await workEmployeeFilterHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.cards),
        findsWidgets,
      );

      await workCardHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.buttonMock),
        findsNothing,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp1000,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.requestCard),
        findsOneWidget,
      );

      await workRequestCardHelper(tester);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.workRequestCard.button,
      );

      expect(
        find.byKey(KWidgetkeys.screen.workEmployee.pagination),
        findsOneWidget,
      );

      await paginationTest(tester);
    },
  );
}

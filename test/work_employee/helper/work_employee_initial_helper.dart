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
        find.byKey(WorkEmployeeKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(WorkEmployeeKeys.subtitle),
        findsOneWidget,
      );

      await workEmployeeFilterHelper(tester);

      expect(
        find.byKey(WorkEmployeeKeys.cards),
        findsWidgets,
      );

      await workCardHelper(tester);

      expect(
        find.byKey(WorkEmployeeKeys.buttonMock),
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
        find.byKey(WorkEmployeeKeys.requestCard),
        findsOneWidget,
      );

      await workRequestCardHelper(tester);

      await scrollingHelper(
        tester: tester,
        itemKey: WorkRequestCardKeys.button,
      );

      expect(
        find.byKey(WorkEmployeeKeys.pagination),
        findsOneWidget,
      );

      await paginationTest(tester);
    },
  );
}

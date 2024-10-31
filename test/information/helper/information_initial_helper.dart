import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> informationInitialHelper(
  WidgetTester tester,
) async {
  // await nawbarHelper(
  //   tester: tester,
  //   searchText: KTestText.field,
  // );
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.information.title),
        findsOneWidget,
      );

      // expect(
      //   find.byKey(KWidgetkeys.screen.information.subtitle),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.information.filter),
        findsOneWidget,
      );

      await filterChipHelper(tester);

      expect(
        find.byKey(KWidgetkeys.screen.information.card),
        findsWidgets,
      );

      await newsCardHelper(tester: tester);

      expect(
        find.byKey(KWidgetkeys.screen.information.buttonMock),
        findsNothing,
      );

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingDown,
      // );

      // await scrollingHelper(
      //   tester: tester,
      //   offset: KTestConstants.scrollingUp500,
      // );

      // expect(
      //   find.byKey(KWidgetkeys.screen.information.button),
      //   findsOneWidget,
      // );
    },
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.information.buttonIcon),
  //   findsNothing,
  // );

  // await changeWindowSizeHelper(
  //   tester: tester,
  //   test: () async => expect(
  //     find.byKey(KWidgetkeys.screen.information.buttonIcon),
  //     findsOneWidget,
  //   ),
  // );
}

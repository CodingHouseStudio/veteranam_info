import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> signUpBottomButtonsHelper(
  WidgetTester tester,
) async {
  //expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.mob),
  //findsWidgets);

  // expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.desk),
  // findsNothing);

  await changeWindowSizeHelper(
    windowsTest: true,
    tester: tester,
    test: () async {
      // expect(
      //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.or),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.title),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.mob),
      //   findsNothing,
      // );

      expect(
        find.byKey(KWidgetkeys.widget.signUpBottomButtons.google),
        findsWidgets,
      );

      await additionalButtonHelper(tester);

      await tester.tap(
        find.byKey(KWidgetkeys.widget.signUpBottomButtons.google),
        warnIfMissed: false,
      );

      await tester.pumpAndSettle();

      // expect(
      //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.facebook),
      //   findsWidgets,
      // );

      // await tester
      //     .tap(find.byKey(KWidgetkeys.widget.signUpBottomButtons.facebook));

      // await tester.pumpAndSettle();

      // expect(
      //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.apple),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.divider),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.desk),
      //   findsOneWidget,
      // );
    },
  );
}

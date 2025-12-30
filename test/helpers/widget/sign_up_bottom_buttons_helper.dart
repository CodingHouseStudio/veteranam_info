import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> signUpBottomButtonsHelper(
  WidgetTester tester,
) async {
  //expect(find.byKey(SignUpBottomButtonsKeys.mob),
  //findsWidgets);

  // expect(find.byKey(SignUpBottomButtonsKeys.desk),
  // findsNothing);

  await changeWindowSizeHelper(
    windowsTest: true,
    tester: tester,
    test: () async {
      // expect(
      //   find.byKey(SignUpBottomButtonsKeys.or),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(SignUpBottomButtonsKeys.title),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(SignUpBottomButtonsKeys.mob),
      //   findsNothing,
      // );

      expect(
        find.byKey(SignUpBottomButtonsKeys.google),
        findsWidgets,
      );

      await additionalButtonHelper(tester);

      await tester.tap(
        find.byKey(SignUpBottomButtonsKeys.google),
        warnIfMissed: false,
      );

      await tester.pumpAndSettle();

      // expect(
      //   find.byKey(SignUpBottomButtonsKeys.facebook),
      //   findsWidgets,
      // );

      // await tester
      //     .tap(find.byKey(SignUpBottomButtonsKeys.facebook));

      // await tester.pumpAndSettle();

      // expect(
      //   find.byKey(SignUpBottomButtonsKeys.apple),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(SignUpBottomButtonsKeys.divider),
      //   findsWidgets,
      // );

      // expect(
      //   find.byKey(SignUpBottomButtonsKeys.desk),
      //   findsOneWidget,
      // );
    },
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarLoginNavigationHelper(
  WidgetTester tester,
) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  expect(
    find.byKey(NawbarKeys.loginIcon),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(NawbarKeys.loginIcon),
  );

  await tester.pump();

  // verify(
  //   () => mockGoRouter.goNamed(
  //     KRoute.login.name,
  //   ),
  // ).called(1);

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(NawbarKeys.loginButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(NawbarKeys.loginButton),
      );

      await tester.pumpAndSettle();

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.login.name,
      //   ),
      // ).called(1);
    },
  );
}

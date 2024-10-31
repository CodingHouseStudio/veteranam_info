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
    find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
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
        find.byKey(KWidgetkeys.widget.nawbar.loginButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(KWidgetkeys.widget.nawbar.loginButton),
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

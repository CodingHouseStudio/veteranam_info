import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarLoginNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
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

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.userRole.name,
    ),
  ).called(1);

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

      verify(
        () => mockGoRouter.goNamed(
          KRoute.userRole.name,
        ),
      ).called(1);
    },
  );
}

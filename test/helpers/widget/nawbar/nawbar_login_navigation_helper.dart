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
    find.byKey(NawbarKeys.userIcon),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(NawbarKeys.userIcon),
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
        find.byKey(NawbarKeys.loginButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(NawbarKeys.loginButton),
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

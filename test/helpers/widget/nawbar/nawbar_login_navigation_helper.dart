import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> nawbarLoginNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
  );

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.iconPersonLogin),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.iconPersonLogin),
  );

  await tester.pump();

  verify(
    () => mockGoRouter.goNamed(
      KRoute.login.name,
    ),
  ).called(1);

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.widget.nawbar.button),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(KWidgetkeys.widget.nawbar.button),
      );

      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.goNamed(
          KRoute.login.name,
        ),
      ).called(1);
    },
  );
}

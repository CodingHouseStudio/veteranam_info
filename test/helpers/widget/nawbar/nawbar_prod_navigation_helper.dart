import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarProdNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(NawbarKeys.discountsButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(NawbarKeys.discountsButton),
      );

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discounts.name,
        ),
      ).called(1);

      expect(
        find.byKey(NawbarKeys.investorsButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(NawbarKeys.investorsButton),
      );

      verify(
        () => mockGoRouter.goNamed(
          KRoute.support.name,
        ),
      ).called(1);

      expect(
        find.byKey(NawbarKeys.feedbackButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(NawbarKeys.feedbackButton),
      );

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);
    },
  );
}

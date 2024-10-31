import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarProdNavigationHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.widget.nawbar.discountsButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(KWidgetkeys.widget.nawbar.discountsButton),
      );

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.discounts.name,
      //   ),
      // ).called(1);

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.investorsButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(KWidgetkeys.widget.nawbar.investorsButton),
      );

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.investors.name,
      //   ),
      // ).called(1);

      expect(
        find.byKey(KWidgetkeys.widget.nawbar.feedbackButton),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(KWidgetkeys.widget.nawbar.feedbackButton),
      );

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.feedback.name,
      //   ),
      // ).called(1);
    },
  );
}

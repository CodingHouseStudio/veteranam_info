import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> cardsScreenHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await homeChangeWindowSizeHelper(
    tester: tester,
    isMobile: true,
    tabletTest: true,
    test: () async {
      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.boxButton,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.boxButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.boxButton));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.aboutProjecSubtitle,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown100,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.discountImage,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.discountTitle,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.discountButton,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.discountButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.discountButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discounts.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.informationImage,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.informationTitle,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.informationButton,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.informationButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.information.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.faqButton,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.faqButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);
    },
  );
}

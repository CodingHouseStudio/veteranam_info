import 'package:flutter/widgets.dart' show ScrollPositionAlignmentPolicy;

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
        itemKey: HomeKeys.boxButton,
      );

      expect(
        find.byKey(HomeKeys.boxButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(HomeKeys.boxButton));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.aboutProjecSubtitle,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown100,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.discountImage,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.discountTitle,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.discountButton,
      );

      expect(
        find.byKey(HomeKeys.discountButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(HomeKeys.discountButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discounts.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.informationImage,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.informationTitle,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.informationButton,
      );

      await tester.tap(find.byKey(HomeKeys.informationButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.information.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.faqButton,
        scrollPositionAlignmentPolicy:
            ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );

      await tester.tap(find.byKey(HomeKeys.faqButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);
    },
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> boxexHelper({
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
        itemKey: KWidgetkeys.screen.home.discountsBox,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.discountsBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discounts.name,
        ),
      ).called(1);

      await tester.tap(find.byKey(KWidgetkeys.screen.home.investorsBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.support.name,
        ),
      ).called(1);

      await tester.tap(find.byKey(KWidgetkeys.screen.home.feedbackBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.informationBox,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.informationBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.information.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.storyBox,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.storyBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.stories.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.workBox,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.home.workBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.work.name,
        ),
      ).called(1);
    },
  );
}

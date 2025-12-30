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
        itemKey: HomeKeys.discountsBox,
      );

      await tester.tap(find.byKey(HomeKeys.discountsBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discounts.name,
        ),
      ).called(1);

      await tester.tap(find.byKey(HomeKeys.investorsBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.support.name,
        ),
      ).called(1);

      await tester.tap(find.byKey(HomeKeys.feedbackBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.informationBox,
      );

      await tester.tap(find.byKey(HomeKeys.informationBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.information.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.storyBox,
      );

      await tester.tap(find.byKey(HomeKeys.storyBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.stories.name,
        ),
      ).called(1);

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.workBox,
      );

      await tester.tap(find.byKey(HomeKeys.workBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.work.name,
        ),
      ).called(1);
    },
  );
}

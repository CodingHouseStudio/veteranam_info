import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> boxexHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
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

      await tester.tap(find.byKey(KWidgetkeys.screen.home.workBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.work.name,
        ),
      ).called(1);

      await tester.tap(find.byKey(KWidgetkeys.screen.home.informationBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.information.name,
        ),
      ).called(1);

      await tester.tap(find.byKey(KWidgetkeys.screen.home.discountsBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discounts.name,
        ),
      ).called(1);

      await tester.tap(find.byKey(KWidgetkeys.screen.home.investorsBox));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.investors.name,
        ),
      ).called(1);
    },
  );
}

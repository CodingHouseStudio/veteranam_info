import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> cardsScreenHelper({
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

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.box.text,
        first: false,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.aboutProjecSubtitle,
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

      await tester.tap(find.byKey(KWidgetkeys.screen.home.discountButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.discounts.name,
        ),
      ).called(1);

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
    },
  );
}

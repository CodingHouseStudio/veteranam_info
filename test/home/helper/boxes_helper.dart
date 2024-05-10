import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> boxexHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
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

  await tester.tap(find.byKey(KWidgetkeys.screen.home.workBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.work.name,
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

  await tester.tap(find.byKey(KWidgetkeys.screen.home.storyBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.story.name,
    ),
  ).called(1);

  await tester.tap(find.byKey(KWidgetkeys.screen.home.investorsBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.investors.name,
    ),
  ).called(1);

  await changeWindowSizeHelper(tester: tester);

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

  await tester.tap(find.byKey(KWidgetkeys.screen.home.workBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.work.name,
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

  await tester.tap(find.byKey(KWidgetkeys.screen.home.storyBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.story.name,
    ),
  ).called(1);

  await tester.tap(find.byKey(KWidgetkeys.screen.home.investorsBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.investors.name,
    ),
  ).called(1);

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

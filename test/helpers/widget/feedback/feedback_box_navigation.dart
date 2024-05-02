import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> feedbackBoxNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp500,
    itemKey: KWidgetkeys.widget.feedbackBox.informationBox,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.feedbackBox.informationBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.information.name,
    ),
  ).called(1);

  await tester.tap(find.byKey(KWidgetkeys.widget.feedbackBox.investorsBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.investors.name,
    ),
  ).called(1);

  await tester.tap(find.byKey(KWidgetkeys.widget.feedbackBox.storyBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.story.name,
    ),
  ).called(1);

  await changeWindowSizeHelper(tester: tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.feedbackBox.informationBox,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.feedbackBox.informationBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.information.name,
    ),
  ).called(1);

  await tester.tap(find.byKey(KWidgetkeys.widget.feedbackBox.investorsBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.investors.name,
    ),
  ).called(1);

  await tester.tap(find.byKey(KWidgetkeys.widget.feedbackBox.storyBox));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.story.name,
    ),
  ).called(1);

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

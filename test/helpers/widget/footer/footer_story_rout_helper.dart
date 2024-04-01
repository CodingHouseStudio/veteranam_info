import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> footerStoryRoutHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    item: KWidgetkeys.footerKeys.storyButton,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.storyButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.storyButton));

  verify(
    () => mockGoRouter.go(
      '${KRoute.home.path}${KRoute.story.path}',
    ),
  ).called(1);
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> storyAddNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(StoryKeys.seccondaryButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: StoryKeys.seccondaryButton,
  );

  await tester.tap(find.byKey(StoryKeys.seccondaryButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.storyAdd.name),
  ).called(1);
}

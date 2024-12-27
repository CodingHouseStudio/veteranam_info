import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> fieldUncorrectHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(find.byKey(KWidgetkeys.screen.storyAdd.storyField), findsOneWidget);

  await messageFieldHelper(tester: tester, message: KTestVariables.fieldEmpty);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.storyAdd.photoButton,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.storyAdd.switchText,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.storyAdd.button,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.storyAdd.button));

  verifyNever(
    () => mockGoRouter.goNamed(KRoute.stories.name),
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async =>
        messageFieldHelper(tester: tester, message: KTestVariables.fieldEmpty),
  );
}

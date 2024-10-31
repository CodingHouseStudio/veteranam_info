import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> feedbackNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.feedbackTitle,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.feedbackButton,
      );

      expect(
        find.byKey(KWidgetkeys.screen.investors.feedbackButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.investors.feedbackButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);
    },
  );
}

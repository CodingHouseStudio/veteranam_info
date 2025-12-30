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
        itemKey: InvestorsKeys.feedbackTitle,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: InvestorsKeys.feedbackButton,
      );

      expect(
        find.byKey(InvestorsKeys.feedbackButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(InvestorsKeys.feedbackButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);
    },
  );
}

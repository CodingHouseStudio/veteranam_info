import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> feedbackBoxNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: KWidgetkeys.screen.feedback.boxSubtitle,
      // );

      expect(
        find.byKey(KWidgetkeys.screen.feedback.boxBackButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.feedback.boxBackButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.home.name,
        ),
      ).called(1);

      expect(
        find.byKey(KWidgetkeys.screen.feedback.boxAgainButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.screen.feedback.boxAgainButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.feedback.name,
        ),
      ).called(1);

      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: KWidgetkeys.screen.feedback.boxInformationBox,
      // );

      // await tester
      //     .tap(find.byKey(KWidgetkeys.screen.feedback.boxInformationBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.information.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(KWidgetkeys.screen.feedback.boxInvestorsBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.investors.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(KWidgetkeys.screen.feedback.boxStoryBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.stories.name,
      //   ),
      // ).called(1);

      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: KWidgetkeys.screen.feedback.boxInformationBox,
      // );

      // await tester
      //     .tap(find.byKey(KWidgetkeys.screen.feedback.boxInformationBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.information.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(KWidgetkeys.screen.feedback.boxInvestorsBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.investors.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(KWidgetkeys.screen.feedback.boxStoryBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.stories.name,
      //   ),
      // ).called(1);
    },
  );
}

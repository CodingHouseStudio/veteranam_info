import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
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
      //   itemKey: FeedbackKeys.boxSubtitle,
      // );

      expect(
        find.byKey(FeedbackKeys.boxBackButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(FeedbackKeys.boxBackButton));

      if (Config.isWeb) {
        verify(
          () => mockGoRouter.goNamed(
            KRoute.home.name,
          ),
        ).called(1);
      } else {
        verify(
          () => mockGoRouter.goNamed(
            KRoute.discounts.name,
          ),
        ).called(1);
      }

      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: FeedbackKeys.boxInformationBox,
      // );

      // await tester
      //     .tap(find.byKey(FeedbackKeys.boxInformationBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.information.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(
      // FeedbackKeys.boxInvestorsBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.investors.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(FeedbackKeys.boxStoryBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.stories.name,
      //   ),
      // ).called(1);

      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: FeedbackKeys.boxInformationBox,
      // );

      // await tester
      //     .tap(find.byKey(FeedbackKeys.boxInformationBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.information.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(
      // FeedbackKeys.boxInvestorsBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.investors.name,
      //   ),
      // ).called(1);

      // await tester.tap(find.byKey(FeedbackKeys.boxStoryBox));

      // verify(
      //   () => mockGoRouter.goNamed(
      //     KRoute.stories.name,
      //   ),
      // ).called(1);
    },
  );
}

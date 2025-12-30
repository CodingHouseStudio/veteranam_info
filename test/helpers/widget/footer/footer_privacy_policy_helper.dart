import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> footerPrivacyPolicyHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    // windowsTest: true,
    test: () async {
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      if (find.byKey(FooterKeys.privacyPolicy).evaluate().isEmpty) {
        await scrollingHelper(
          tester: tester,
          offset: KTestConstants.scrollingDown,
        );
      }

      expect(
        find.byKey(FooterKeys.privacyPolicy),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: FooterKeys.privacyPolicy,
      );

      await tester.tap(find.byKey(FooterKeys.privacyPolicy));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.privacyPolicy.name,
        ),
      ).called(1);
    },
  );
}

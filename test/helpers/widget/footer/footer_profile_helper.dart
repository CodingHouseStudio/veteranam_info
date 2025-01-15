import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> footerProfileHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await changeWindowSizeHelper(
    tester: tester,
    // windowsTest: true,
    test: () async {
      expect(
        find.byKey(FooterKeys.profileButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(FooterKeys.profileButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.profile.name,
        ),
      ).called(1);
    },
  );
}

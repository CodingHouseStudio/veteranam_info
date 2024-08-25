import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

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
        find.byKey(KWidgetkeys.widget.footer.profileButton),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.footer.profileButton));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.profile.name,
        ),
      ).called(1);
    },
  );
}

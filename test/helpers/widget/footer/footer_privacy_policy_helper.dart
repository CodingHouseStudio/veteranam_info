import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> footerPrivacyPolicyHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(KWidgetkeys.widget.footer.privacyPolicy),
        findsOneWidget,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.footer.privacyPolicy));

      verify(
        () => mockGoRouter.goNamed(
          KRoute.privacyPolicy.name,
        ),
      ).called(1);
    },
  );
}

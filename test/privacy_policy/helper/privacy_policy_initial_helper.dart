import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> privacyPolicyInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.privacyPolicy.text),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.privacyPolicy.closeIcon),
        findsOneWidget,
      );

      // final link = find.textContaining(KAppText.email).last;

      // await tester.ensureVisible(link);

      // expect(link, findsOneWidget);

      // final center = tester.getCenter(link);

      // await tester.tapAt(center);

      // await tester.pumpAndSettle();

      // await dialogSnackBarTextHelper(tester: tester);
    },
  );
}

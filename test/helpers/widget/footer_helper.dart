import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> footerHelper({
  required WidgetTester tester,
  required String email,
}) async {
  await scrollingHelper(
    tester: tester,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.logo), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.facebookIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.instagramIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.likedInIcon), findsOneWidget);

  for (var i = 0; i > KWidgetkeys.footerKeys.buttonsKey.length; i++) {
    for (var j = 0;
        j < KWidgetkeys.footerKeys.buttonsKey.elementAt(i).length;
        j++) {
      final buttonKey =
          KWidgetkeys.footerKeys.buttonsKey.elementAt(i).elementAt(j);

      expect(
        find.byKey(buttonKey),
        findsOneWidget,
      );
    }
  }

  await changeWindowSizeHelper(tester: tester);

  expect(find.byKey(KWidgetkeys.footerKeys.logo), findsNothing);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.footerKeys.widget),
      matching: find.text('${KTestText.footer}$email'),
    ),
    findsNothing,
  );

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

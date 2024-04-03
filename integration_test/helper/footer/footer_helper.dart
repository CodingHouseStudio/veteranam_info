import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../constants.dart';
import '../helper.dart';

Future<void> footerHelper({
  required WidgetTester tester,
  required String email,
}) async {
  await scrollingHelper(
    tester: tester,
  );

  await changeWindowSizeHelper(
    tester: tester,
    windowSize: KTestConstants.windowMobileSize,
  );

  expect(find.byKey(KWidgetkeys.widgetKeys.footerKeys.logo), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.facebookIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.instagramIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widgetKeys.footerKeys.likedInIcon),
    findsOneWidget,
  );

  for (var i = 0;
      i > KWidgetkeys.widgetKeys.footerKeys.buttonsKey.length;
      i++) {
    for (var j = 0;
        j < KWidgetkeys.widgetKeys.footerKeys.buttonsKey.elementAt(i).length;
        j++) {
      final buttonKey = KWidgetkeys.widgetKeys.footerKeys.buttonsKey
          .elementAt(i)
          .elementAt(j);

      expect(
        find.byKey(buttonKey),
        findsOneWidget,
      );
    }
  }

  await changeWindowSizeHelper(tester: tester);

  expect(find.byKey(KWidgetkeys.widgetKeys.footerKeys.logo), findsNothing);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widgetKeys.footerKeys.widget),
      matching: find.text('${KTestText.footer}$email'),
    ),
    findsNothing,
  );

  await changeWindowSizeHelper(tester: tester);
}

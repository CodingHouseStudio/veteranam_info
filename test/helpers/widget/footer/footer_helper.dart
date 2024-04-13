import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> footerHelper({
  required WidgetTester tester,
  required String email,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
    itemKey: null,
  );

  expect(find.byKey(KWidgetkeys.widget.footer.logo), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.footer.facebookIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.instagramIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.footer.likedInIcon),
    findsOneWidget,
  );

  for (var i = 0; i > KWidgetkeys.widget.footer.buttonsKey.length; i++) {
    for (var j = 0;
        j < KWidgetkeys.widget.footer.buttonsKey.elementAt(i).length;
        j++) {
      final buttonKey =
          KWidgetkeys.widget.footer.buttonsKey.elementAt(i).elementAt(j);

      expect(
        find.byKey(buttonKey),
        findsOneWidget,
      );
    }
  }

  // await changeWindowSizeHelper(tester: tester);

  // expect(find.byKey(KWidgetkeys.widget.footer.logo), findsNothing);

  // expect(
  //   find.descendant(
  //     of: find.byKey(KWidgetkeys.widget.footer.widget),
  //     matching: find.text('${KTestText.footer}$email'),
  //   ),
  //   findsNothing,
  // );

  // await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

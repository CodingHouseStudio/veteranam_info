import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> footerHelper(
  WidgetTester tester,
  // required String email,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp500,
  );

  expect(find.byKey(KWidgetkeys.widget.footer.logo), findsOneWidget);

  for (final buttonKey in KWidgetkeys.widget.footer.buttonsKey) {
    await scrollingHelper(tester: tester, itemKey: buttonKey);

    expect(
      find.byKey(buttonKey),
      findsOneWidget,
    );
  }

  // expect(
  //   find.descendant(
  //     of: find.byKey(KWidgetkeys.widget.footer.widget),
  //     matching: find.text('${KTestText.footer}$email'),
  //   ),
  //   findsOneWidget,
  // );

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

  await changeWindowSizeHelper(tester: tester);

  expect(find.byKey(KWidgetkeys.widget.footer.logo), findsNothing);

  // expect(
  //   find.descendant(
  //     of: find.byKey(KWidgetkeys.widget.footer.widget),
  //     matching: find.text('${KTestText.footer}$email'),
  //   ),
  //   findsNothing,
  // );

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

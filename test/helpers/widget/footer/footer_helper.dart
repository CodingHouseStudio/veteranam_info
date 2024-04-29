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

  for (final buttonKey in KWidgetkeys.widget.footer.buttonsKey) {
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

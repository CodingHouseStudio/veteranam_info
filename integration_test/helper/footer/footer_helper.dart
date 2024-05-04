import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> footerHelper({
  required WidgetTester tester,
  required String email,
}) async {
  await changeWindowSizeHelperInt(
    tester: tester,
  );
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrolling,
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

  await changeWindowSizeHelperInt(tester: tester, setDefaultSize: true);

  expect(find.byKey(KWidgetkeys.widget.footer.logo), findsNothing);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.widget.footer.widget),
      matching: find.text('${KTestText.footer}$email'),
    ),
    findsNothing,
  );
}

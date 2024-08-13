import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> footerHelper(
  WidgetTester tester,
  // required String email,
) async {
  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.footer.title,
    offset: KTestConstants.scrollingUp200,
  );

  expect(find.byKey(KWidgetkeys.widget.footer.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.button), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.sections), findsOneWidget);

  if (Config.isDevelopment) {
    expect(find.byKey(KWidgetkeys.widget.footer.information), findsOneWidget);

    await scrollingHelperInt(
      tester: tester,
      itemKey: KWidgetkeys.widget.footer.information,
    );
  }

  for (final buttonKey in Config.isDevelopment
      ? KWidgetkeys.widget.footer.buttonsKey.reversed
      : KWidgetkeys.widget.footer.buttonsProdKey) {
    expect(
      find.byKey(buttonKey),
      findsOneWidget,
    );
  }

  expect(find.byKey(KWidgetkeys.widget.footer.contact), findsOneWidget);

  await emailButtonHelperInt(tester);

  // expect(find.byKey(KWidgetkeys.widget.footer.emailText), findsOneWidget);

  // expect(find.byKey(KWidgetkeys.widget.footer.emailIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.likedInIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.instagramIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.facebookIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.logo), findsOneWidget);

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.footer.logo,
  );

  expect(find.byKey(KWidgetkeys.widget.footer.madeBy), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.rightReserved), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.privacyPolicy), findsOneWidget);
}

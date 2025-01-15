import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

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
    itemKey: FooterKeys.title,
    offset: KTestConstants.scrollingUp200,
  );

  expect(find.byKey(FooterKeys.title), findsOneWidget);

  expect(find.byKey(FooterKeys.button), findsOneWidget);

  expect(find.byKey(FooterKeys.sections), findsOneWidget);

  if (Config.isDevelopment) {
    expect(find.byKey(FooterKeys.information), findsOneWidget);

    await scrollingHelper(
      tester: tester,
      itemKey: FooterKeys.information,
    );
  }

  for (final buttonKey in Config.isDevelopment
      ? FooterKeys.buttonsKey.reversed
      : FooterKeys.buttonsProdKey) {
    expect(
      find.byKey(buttonKey),
      findsOneWidget,
    );
  }

  expect(find.byKey(FooterKeys.contact), findsOneWidget);

  await emailButtonHelper(tester);

  // expect(find.byKey(FooterKeys.emailText), findsOneWidget);

  // expect(find.byKey(FooterKeys.emailIcon), findsOneWidget);

  expect(find.byKey(FooterKeys.likedInIcon), findsOneWidget);

  expect(find.byKey(FooterKeys.instagramIcon), findsOneWidget);

  expect(find.byKey(FooterKeys.facebookIcon), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.facebookIcon,
  );

  expect(find.byKey(FooterKeys.logo), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.logo,
  );

  expect(find.byKey(FooterKeys.madeBy), findsOneWidget);

  expect(find.byKey(FooterKeys.rightReserved), findsOneWidget);

  expect(find.byKey(FooterKeys.privacyPolicy), findsOneWidget);
}

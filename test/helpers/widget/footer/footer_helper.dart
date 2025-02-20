import 'package:flutter/widgets.dart' show ScrollPositionAlignmentPolicy;
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

  if (find.byKey(FooterKeys.title).evaluate().isEmpty) {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingUp500,
    );
  }

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.title,
    scrollPositionAlignmentPolicy:
        ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
  );

  expect(find.byKey(FooterKeys.title), findsOneWidget);

  expect(find.byKey(FooterKeys.button), findsOneWidget);

  expect(find.byKey(FooterKeys.sections), findsOneWidget);

  if (Config.isDevelopment) {
    expect(find.byKey(FooterKeys.information), findsOneWidget);

    await scrollingHelper(
      tester: tester,
      itemKey: FooterKeys.information,
      scrollPositionAlignmentPolicy:
          ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
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

  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown100,
  );

  expect(find.byKey(FooterKeys.contact), findsOneWidget);

  if (appVersion.isDesk || appVersion.isTablet) {
    await emailButtonHelper(tester);
  }

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.contact,
  );

  if (find.byKey(FooterKeys.likedInIcon).evaluate().isEmpty) {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown,
    );
  }

  // expect(find.byKey(FooterKeys.emailText), findsOneWidget);

  // expect(find.byKey(FooterKeys.emailIcon), findsOneWidget);

  expect(find.byKey(FooterKeys.likedInIcon), findsOneWidget);

  expect(find.byKey(FooterKeys.instagramIcon), findsOneWidget);

  expect(find.byKey(FooterKeys.facebookIcon), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.facebookIcon,
    scrollPositionAlignmentPolicy: Config.isDevelopment
        ? ScrollPositionAlignmentPolicy.keepVisibleAtEnd
        : ScrollPositionAlignmentPolicy.explicit,
  );

  if (find.byKey(FooterKeys.logo).evaluate().isEmpty) {
    await scrollingHelper(
      tester: tester,
      offset: KTestConstants.scrollingDown100,
    );
  }

  expect(find.byKey(FooterKeys.logo), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: FooterKeys.logo,
    scrollPositionAlignmentPolicy:
        ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
  );

  expect(find.byKey(FooterKeys.madeBy), findsOneWidget);

  expect(find.byKey(FooterKeys.rightReserved), findsOneWidget);

  expect(find.byKey(FooterKeys.privacyPolicy), findsOneWidget);
}

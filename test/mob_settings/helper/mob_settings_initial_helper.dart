import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> mobSettingsInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.nawbar.pageName),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.faq),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.languagesSwitcher),
    findsOneWidget,
  );

  await languageSwitcherHelper(tester);

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.offlinesSwitcher),
    findsOneWidget,
  );

  await switchOfflineHelper(tester: tester, enabled: false, isActive: true);

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.offlinesTitle),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.screen.mobSettings.offlinesTitle),
    // warnIfMissed: false,
  );

  await tester.pumpAndSettle(const Duration(seconds: 15));

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.email),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.email));

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.feedbackButton),
    findsOneWidget,
  );

  await doubleButtonHelper(tester);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.mobSettings.feedbackButton,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.likedInIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.instagramIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.facebookIcon),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.mobSettings.facebookIcon,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.privacyPolicy),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.bugButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.bugButton));

  await tester.pumpAndSettle();

  await mobFeedbackOpenHelper(test: mobFeedbackHelper, tester: tester);
}

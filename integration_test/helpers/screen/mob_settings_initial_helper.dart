import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import '../helpers.dart';

Future<void> mobSettingsInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(MobSettingsKeys.title),
    findsOneWidget,
  );

  expect(
    find.byKey(MobSettingsKeys.faq),
    findsOneWidget,
  );

  expect(
    find.byKey(MobSettingsKeys.languagesSwitcher),
    findsOneWidget,
  );

  await languageSwitcherHelper(tester);

  expect(
    find.byKey(MobSettingsKeys.offlinesSwitcher),
    findsOneWidget,
  );

  await switchHelper(tester: tester, enabled: false, isActive: true);

  expect(
    find.byKey(MobSettingsKeys.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(MobSettingsKeys.email),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MobSettingsKeys.email));

  expect(
    find.byKey(MobSettingsKeys.feedbackButton),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: MobSettingsKeys.feedbackButton,
  );

  expect(
    find.byKey(MobSettingsKeys.linkedInIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(MobSettingsKeys.instagramIcon),
    findsOneWidget,
  );

  expect(
    find.byKey(MobSettingsKeys.facebookIcon),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: MobSettingsKeys.facebookIcon,
  );

  expect(
    find.byKey(MobSettingsKeys.privacyPolicy),
    findsOneWidget,
  );

  expect(
    find.byKey(MobSettingsKeys.bugButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MobSettingsKeys.bugButton));

  await tester.pumpAndSettle();

  // await mobFeedbackOpenHelperkHelper(test: mobFeedbackHelper,
  //tester: tester);
}

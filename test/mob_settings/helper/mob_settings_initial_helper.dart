import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> mobSettingsInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.title1),
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
    find.byKey(KWidgetkeys.screen.mobSettings.title2),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.email),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.mobSettings.email));

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.button),
    findsOneWidget,
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

  expect(
    find.byKey(KWidgetkeys.screen.mobSettings.privacyPolicy),
    findsOneWidget,
  );
}

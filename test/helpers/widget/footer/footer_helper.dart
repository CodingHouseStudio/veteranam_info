import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> footerHelper({
  required WidgetTester tester,
  required String email,
}) async {
  await scrollingHelper(
    tester: tester,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.logo), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.aboutUsButton), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.footerKeys.consultationOnlineButton),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.footerKeys.contactButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.discountsButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.facebookIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.informationButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.instagramIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.investorsButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.likedInIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.profileButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.storyButton), findsOneWidget);

  expect(find.byKey(KWidgetkeys.footerKeys.workButton), findsOneWidget);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.footerKeys.contactButton),
      matching: find.text('${KTestText.footer}$email'),
    ),
    findsOneWidget,
  );

  await changeWindowSizeHelper(tester: tester);

  expect(find.byKey(KWidgetkeys.footerKeys.logo), findsNothing);

  expect(
    find.descendant(
      of: find.byKey(KWidgetkeys.footerKeys.contactButton),
      matching: find.text('${KTestText.footer}$email'),
    ),
    findsNothing,
  );

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

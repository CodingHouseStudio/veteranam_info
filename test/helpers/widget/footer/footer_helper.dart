import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../helpers.dart';

Future<void> footerHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
  );

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
}

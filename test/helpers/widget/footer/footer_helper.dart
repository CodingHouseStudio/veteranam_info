import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

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
    itemKey: KWidgetkeys.widget.footer.title,
    offset: KTestConstants.scrollingUp500,
  );

  expect(find.byKey(KWidgetkeys.widget.footer.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.button), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.sections), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.information), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.footer.information,
  );

  for (final buttonKey in KWidgetkeys.widget.footer.buttonsKey.reversed) {
    expect(
      find.byKey(buttonKey),
      findsOneWidget,
    );
  }

  expect(find.byKey(KWidgetkeys.widget.footer.contact), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.emailText), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.emailIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.likedInIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.instagramIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.facebookIcon), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.logo), findsOneWidget);

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.footer.logo,
  );

  expect(find.byKey(KWidgetkeys.widget.footer.madeBy), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.rightReserved), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widget.footer.privacyPolicy), findsOneWidget);
}

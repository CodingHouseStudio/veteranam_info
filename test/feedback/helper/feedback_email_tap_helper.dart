import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../helpers/helpers.dart';

Future<void> feedbackEmailTapHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.feedback.subtitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.feedback.emailText),
    findsOneWidget,
  );

  await tester.tap(find.text(KAppText.email));

  await tester.pumpAndSettle();
}
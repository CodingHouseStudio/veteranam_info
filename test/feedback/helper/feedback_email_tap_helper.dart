import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/text/text_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../helpers/helpers.dart';

Future<void> feedbackEmailTapHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: FeedbackKeys.subtitle,
  );

  expect(
    find.byKey(FeedbackKeys.emailText),
    findsOneWidget,
  );

  await tester.tap(find.text(KAppText.email));

  await tester.pumpAndSettle();
}

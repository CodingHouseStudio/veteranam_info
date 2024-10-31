import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> notificationLinkCorrectHelper(
  WidgetTester tester,
) async {
  await notificationLinkSaveHelper(
    tester: tester,
    link: KTestText.linkModel.link,
  );

  expect(find.text(KTestText.linkModel.link), findsNothing);

  expect(
    find.byKey(KWidgetkeys.widget.notificationLink.thankText),
    findsOneWidget,
  );
}

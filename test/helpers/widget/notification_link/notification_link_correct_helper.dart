import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> notificationLinkCorrectHelper(
  WidgetTester tester,
) async {
  await notificationLinkSaveHelper(
    tester: tester,
    link: KTestVariables.linkModel.link,
  );

  expect(find.text(KTestVariables.linkModel.link), findsNothing);

  expect(
    find.byKey(NotificationLinkKeys.thankText),
    findsOneWidget,
  );
}

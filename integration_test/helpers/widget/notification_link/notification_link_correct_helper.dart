import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> notificationLinkCorrectHelper(
  WidgetTester tester,
) async {
  await notificationLinkSaveHelper(
    tester: tester,
    link: KTestVariables.link,
  );

  expect(find.text(KTestVariables.link), findsNothing);
}

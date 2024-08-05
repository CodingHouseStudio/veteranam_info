import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> notificationLinkCorrectHelper(
  WidgetTester tester,
) async {
  await notificationLinkSaveHelper(
    tester: tester,
    link: KTestText.link,
  );

  expect(find.text(KTestText.link), findsNothing);
}

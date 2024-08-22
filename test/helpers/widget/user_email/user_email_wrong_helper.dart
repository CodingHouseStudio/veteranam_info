import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';

Future<void> userEmailWrongHelper(
  WidgetTester tester,
) async {
  await userEmailSaveHelper(tester: tester, email: KTestText.field);

  expect(find.text(KTestText.field), findsOneWidget);
}

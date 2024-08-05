import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> aboutUsInitialHelper(WidgetTester tester) async {
  expect(find.byKey(KWidgetkeys.screen.aboutUs.screen), findsOneWidget);

  await rateHelper(tester);

  await chatInputHelper(tester);
}

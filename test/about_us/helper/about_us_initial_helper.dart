import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';

Future<void> aboutUsInitialHelper(WidgetTester tester) async {
  await rateHelper(tester);

  await chatInputHelper(tester);

  await switchOfflineHelper(tester: tester);
}

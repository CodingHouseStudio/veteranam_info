import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../helpers.dart';

Future<void> boxHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    item: KWidgetkeys.boxKeys.text,
  );

  expect(find.byKey(KWidgetkeys.boxKeys.text), findsOneWidget);

  expect(find.byKey(KWidgetkeys.boxKeys.icon), findsOneWidget);
}

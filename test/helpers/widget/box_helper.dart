import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> boxHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingDown100,
    itemKey: KWidgetkeys.widgetKeys.boxKeys.text,
  );

  expect(find.byKey(KWidgetkeys.widgetKeys.boxKeys.text), findsOneWidget);

  expect(find.byKey(KWidgetkeys.widgetKeys.boxKeys.icon), findsOneWidget);
}

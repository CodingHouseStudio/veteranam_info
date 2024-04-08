import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> chekPointHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPoint.widget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.widget),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.icon),
    findsNothing,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.checkPoint.widget));

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.icon),
    findsOneWidget,
  );
}

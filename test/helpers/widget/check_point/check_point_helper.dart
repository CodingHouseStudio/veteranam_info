import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> chekPointHelper({
  required WidgetTester tester,
  bool hasAmount = false,
}) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPoint.widget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.icon),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.text),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPoint.widget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.checkPoint.widget).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.icon),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.checkPoint.widget).first);

  await tester.pumpAndSettle();
}

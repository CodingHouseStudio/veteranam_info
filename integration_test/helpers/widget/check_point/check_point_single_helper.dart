import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> chekPointSingleHelper({
  required WidgetTester tester,
  bool hasAmount = false,
}) async {
  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPointSingle.widget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.checkPointSingle.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPointSingle.icon),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.checkPoint.ammount),
    hasAmount ? findsWidgets : findsNothing,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.checkPointSingle.widget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.checkPointSingle.widget).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.checkPointSingle.icon),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.checkPointSingle.widget).first);

  await tester.pumpAndSettle();

  expect(
    find.byKey(KWidgetkeys.widget.checkPointSingle.icon),
    findsNothing,
  );
}

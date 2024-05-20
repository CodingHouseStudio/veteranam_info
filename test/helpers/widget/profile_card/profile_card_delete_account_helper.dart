import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> profileCardDeleteAccountHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.profileCardWidget.deleteButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.profileCardWidget.deleteButton,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.profileCardWidget.deleteButton));

  await tester.pumpAndSettle();

  await dialogDeleteAccountHelper(tester);
}

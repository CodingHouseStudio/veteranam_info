import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> profileCardDeleteAccountHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.profileCardWidget.deleteButton),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.profileCardWidget.deleteButton,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.profileCardWidget.deleteButton));

  await tester.pumpAndSettle();

  await dialogDeleteAccountHelper(tester);
}

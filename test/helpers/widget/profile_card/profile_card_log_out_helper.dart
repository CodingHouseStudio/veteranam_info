import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> profileCardLogOutHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.profileCardWidget.logOutButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.profileCardWidget.logOutButton,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.profileCardWidget.logOutButton));

  await tester.pumpAndSettle();

  await dialogLogOutHelper(tester);
}

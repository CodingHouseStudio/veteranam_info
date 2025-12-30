import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> additionalButtonHelper(
  WidgetTester tester,
) async {
  final isDesk = find.byKey(ButtonAdditionalKeys.desk).evaluate().isNotEmpty;

  expect(
    find.byKey(ButtonAdditionalKeys.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(ButtonAdditionalKeys.mob),
    isDesk ? findsNothing : findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: isDesk ? ButtonAdditionalKeys.desk : ButtonAdditionalKeys.mob,
  );
  expect(
    find.byKey(ButtonAdditionalKeys.icon),
    findsWidgets,
  );
  expect(
    find.byKey(ButtonAdditionalKeys.text),
    findsWidgets,
  );

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: ButtonAdditionalKeys.text,
    );
  }
}

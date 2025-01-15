import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> doubleButtonHelper(
  WidgetTester tester,
) async {
  final isDesk = find.byKey(DoubleButtonKeys.desk).evaluate().isNotEmpty;

  expect(
    find.byKey(DoubleButtonKeys.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(DoubleButtonKeys.mob),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(DoubleButtonKeys.icon), findsWidgets);

  expect(find.byKey(DoubleButtonKeys.text), findsWidgets);

  expect(find.byKey(DoubleButtonKeys.rotateIcon), findsNothing);

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: DoubleButtonKeys.text,
      hoverElement: DoubleButtonKeys.rotateIcon,
    );
  }
}

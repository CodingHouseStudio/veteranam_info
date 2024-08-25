import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> doubleButtonHelper(
  WidgetTester tester,
) async {
  final isDesk =
      find.byKey(KWidgetkeys.widget.doubleButton.desk).evaluate().isNotEmpty;

  expect(
    find.byKey(KWidgetkeys.widget.doubleButton.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.doubleButton.mob),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.doubleButton.icon), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.doubleButton.text), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.doubleButton.rotateIcon), findsNothing);

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: KWidgetkeys.widget.doubleButton.text,
      hoverElement: KWidgetkeys.widget.doubleButton.rotateIcon,
    );
  }
}

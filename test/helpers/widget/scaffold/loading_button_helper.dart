import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> loadingButtonHelper(
  WidgetTester tester,
) async {
  final isDesk =
      find.byKey(KWidgetkeys.widget.loadingButton.desk).evaluate().isNotEmpty;

  expect(
    find.byKey(KWidgetkeys.widget.loadingButton.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.loadingButton.mob),
    isDesk ? findsNothing : findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.loadingButton.icon), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.loadingButton.text), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.loadingButton.loadingIcon),
    findsNothing,
  );

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: KWidgetkeys.widget.loadingButton.text,
      hoverElement: KWidgetkeys.widget.loadingButton.loadingIcon,
      usePump: true,
    );
  }
}

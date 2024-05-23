import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../../text_dependency.dart';

Future<void> filterBoxHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.filter.widget), findsWidgets);

  await chipHelper(tester);

  await dropChipHelper(
    tester: tester,
    dropChipKey: KWidgetkeys.widget.dropChip.widget,
    buttonKey: KWidgetkeys.widget.dropChip.buttons,
  );
}

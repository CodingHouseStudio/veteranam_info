import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> additionalButtonHelper(
  WidgetTester tester,
) async {
  final isDesk = find
      .byKey(KWidgetkeys.widget.buttonAdditional.desk)
      .evaluate()
      .isNotEmpty;

  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.desk),
    isDesk ? findsWidgets : findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.mob),
    isDesk ? findsNothing : findsWidgets,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: isDesk
        ? KWidgetkeys.widget.buttonAdditional.desk
        : KWidgetkeys.widget.buttonAdditional.mob,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.icon),
    findsWidgets,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.text),
    findsWidgets,
  );

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: KWidgetkeys.widget.buttonAdditional.text,
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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
    isDesk ? findsOneWidget : findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.mob),
    isDesk ? findsNothing : findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: isDesk
        ? KWidgetkeys.widget.buttonAdditional.desk
        : KWidgetkeys.widget.buttonAdditional.mob,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.icon),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.text),
    findsOneWidget,
  );

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: KWidgetkeys.widget.buttonAdditional.text,
    );
  }
}

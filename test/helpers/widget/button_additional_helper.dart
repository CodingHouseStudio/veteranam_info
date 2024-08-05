import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> additionalButtonHelper(
  WidgetTester tester,
) async {
  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.buttonAdditional.button,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.button),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.buttonIcon),
    findsOneWidget,
  );
  expect(
    find.byKey(KWidgetkeys.widget.buttonAdditional.buttonText),
    findsOneWidget,
  );
}

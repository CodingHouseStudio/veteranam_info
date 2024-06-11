import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> informationFailureHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.information.card),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.information.buttonMock),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}

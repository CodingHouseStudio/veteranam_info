import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> investorsFailureHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.information.card),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.investors.buttonMock),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}

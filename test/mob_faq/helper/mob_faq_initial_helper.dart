import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> mobFaqInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(NawbarKeys.pageName),
    findsOneWidget,
  );

  expect(
    find.byKey(MobFaqKeys.buttonMock),
    findsNothing,
  );

  expect(
    find.byKey(MobFaqKeys.list),
    findsWidgets,
  );

  await questionHelper(tester);

  await dialogFailureGetHelper(tester: tester, isFailure: false);
}

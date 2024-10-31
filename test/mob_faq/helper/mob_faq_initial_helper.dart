import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> mobFaqInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.nawbar.pageName),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobFaq.buttonMock),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.mobFaq.list),
    findsWidgets,
  );

  await questionHelper(tester);

  await dialogFailureGetHelper(tester: tester, isFailure: false);
}

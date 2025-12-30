import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> errorInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(ErrorKeys.title),
    findsOneWidget,
  );

  expect(
    find.byKey(ErrorKeys.button),
    findsOneWidget,
  );
}

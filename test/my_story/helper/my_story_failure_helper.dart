import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> myStoryFailureHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(MyStoryKeys.card),
    findsNothing,
  );

  await dialogFailureGetTapHelper(tester: tester);
}

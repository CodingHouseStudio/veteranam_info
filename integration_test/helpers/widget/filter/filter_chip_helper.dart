import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> filterChipHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(FilterChipKeys.widget), findsWidgets);

  await chipHelper(tester);
}

import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> storyAddFailureHelper(
  WidgetTester tester,
) async {
  await fieldCorrectHelper(tester);

  await dialogSnackBarTextHelper(tester: tester);
}

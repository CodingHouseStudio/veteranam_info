import 'package:flutter_test/flutter_test.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> signUpFailureHelper(
  WidgetTester tester,
) async {
  await wrongSubmitedHelper(
    tester,
  );

  await dialogSnackBarTextHelper(tester: tester);
}

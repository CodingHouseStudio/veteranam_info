import 'package:flutter_test/flutter_test.dart';

import '../../text_dependency.dart';
import 'helper.dart';

Future<void> loginFailureHelper(
  WidgetTester tester,
) async {
  await wrongSubmitedHelper(
    tester,
  );

  await dialogFailureSetHelper(tester: tester);
}

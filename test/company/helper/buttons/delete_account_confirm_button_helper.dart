import 'package:flutter_test/flutter_test.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> deleteAccountConfirmButtonlHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await deleteAccountDialoglHelper(tester);

  await confirmDialogHelper(
    tester,
    isPop: false,
  );
}

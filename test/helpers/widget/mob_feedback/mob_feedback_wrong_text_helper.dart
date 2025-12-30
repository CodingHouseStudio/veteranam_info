import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../../test_dependency.dart';

Future<void> mobFeedbackWrongTextHelper(
  WidgetTester tester,
) async {
  await mobFeedbackEnterTextHelper(
    tester: tester,
    message: KTestVariables.fieldEmpty,
    email: KTestVariables.userEmailIncorrect,
  );

  expect(
    find.byKey(MobFeedbackKeys.widget),
    findsOneWidget,
  );
}

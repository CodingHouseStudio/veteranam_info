import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> signUpBottomButtonsHelper(
  WidgetTester tester,
) async {
  //expect(find.byKey(SignUpBottomButtonsKeys.mob),
  //findsWidgets);

  // expect(find.byKey(SignUpBottomButtonsKeys.desk),
  // findsNothing);

  expect(
    find.byKey(SignUpBottomButtonsKeys.or),
    findsWidgets,
  );

  expect(
    find.byKey(SignUpBottomButtonsKeys.title),
    findsWidgets,
  );

  // expect(
  //   find.byKey(SignUpBottomButtonsKeys.mob),
  //   findsNothing,
  // );

  expect(
    find.byKey(SignUpBottomButtonsKeys.google),
    findsWidgets,
  );

  await additionalButtonHelper(tester);

  expect(
    find.byKey(SignUpBottomButtonsKeys.facebook),
    findsWidgets,
  );

  expect(
    find.byKey(SignUpBottomButtonsKeys.apple),
    findsWidgets,
  );

  // expect(
  //   find.byKey(SignUpBottomButtonsKeys.divider),
  //   findsWidgets,
  // );

  // expect(
  //   find.byKey(SignUpBottomButtonsKeys.desk),
  //   findsOneWidget,
  // );
}

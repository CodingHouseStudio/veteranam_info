import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> signUpBottomButtonsHelper(
  WidgetTester tester,
) async {
  //expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.mob),
  //findsWidgets);

  // expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.desk),
  // findsNothing);

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.or),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.title),
    findsWidgets,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.mob),
  //   findsNothing,
  // );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.google),
    findsWidgets,
  );

  await additionalButtonHelper(tester);

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.facebook),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.apple),
    findsWidgets,
  );

  // expect(
  //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.divider),
  //   findsWidgets,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.widget.signUpBottomButtons.desk),
  //   findsOneWidget,
  // );
}
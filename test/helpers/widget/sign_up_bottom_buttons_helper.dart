import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../change_window_size_helper.dart';

Future<void> signUpBottomButtonsHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.or), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.title),
    findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.mob), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.google),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.facebook),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.apple),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.divider),
    findsNothing,
  );

  expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.desk), findsNothing);

  await changeWindowSizeHelper(tester: tester);

  expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.or), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.title),
    findsWidgets,
  );

  expect(find.byKey(KWidgetkeys.widget.signUpBottomButtons.mob), findsNothing);

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.google),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.facebook),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.apple),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.divider),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.widget.signUpBottomButtons.desk),
    findsOneWidget,
  );

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

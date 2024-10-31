import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> menuDialogHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.menuDialog.dialog), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.menuDialog.discountsButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.menuDialog.discountsButton));

  // verify(
  //   () => mockGoRouter.goNamed(KRoute.discounts.name),
  // ).called(1);

  expect(
    find.byKey(KWidgetkeys.widget.menuDialog.investorsButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.menuDialog.investorsButton));

  // verify(
  //   () => mockGoRouter.goNamed(KRoute.investors.name),
  // ).called(1);

  expect(
    find.byKey(KWidgetkeys.widget.menuDialog.feedbackButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.menuDialog.feedbackButton));

  // verify(
  //   () => mockGoRouter.goNamed(KRoute.feedback.name),
  // ).called(1);

  expect(
    find.byKey(KWidgetkeys.widget.menuDialog.languageSwitcher),
    findsOneWidget,
  );

  await languageSwitcherHelper(tester);

  expect(
    find.byKey(KWidgetkeys.widget.menuDialog.linkedIn),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.menuDialog.linkedIn));

  expect(
    find.byKey(KWidgetkeys.widget.menuDialog.facebook),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.menuDialog.facebook));

  expect(
    find.byKey(KWidgetkeys.widget.menuDialog.instagram),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.menuDialog.instagram));
}

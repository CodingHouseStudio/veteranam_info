import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> menuDialogHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(find.byKey(MenuDialogKeys.dialog), findsOneWidget);

  expect(
    find.byKey(MenuDialogKeys.discountsButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MenuDialogKeys.discountsButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.discounts.name),
  ).called(1);

  await tester.pumpAndSettle();

  expect(
    find.byKey(MenuDialogKeys.discountsButton),
    findsNothing,
  );

  await openNawbarMenuHelper(tester: tester, mockGoRouter: mockGoRouter);

  expect(
    find.byKey(MenuDialogKeys.investorsButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MenuDialogKeys.investorsButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.support.name),
  ).called(1);

  await tester.pumpAndSettle();

  expect(
    find.byKey(MenuDialogKeys.investorsButton),
    findsNothing,
  );

  await openNawbarMenuHelper(tester: tester, mockGoRouter: mockGoRouter);

  expect(
    find.byKey(MenuDialogKeys.feedbackButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MenuDialogKeys.feedbackButton));

  verify(
    () => mockGoRouter.goNamed(KRoute.feedback.name),
  ).called(1);

  await tester.pumpAndSettle();

  expect(
    find.byKey(MenuDialogKeys.feedbackButton),
    findsNothing,
  );

  await openNawbarMenuHelper(tester: tester, mockGoRouter: mockGoRouter);

  expect(
    find.byKey(MenuDialogKeys.languageSwitcher),
    findsOneWidget,
  );

  await languageSwitcherHelper(
    tester,
    isMob: true,
  );

  expect(
    find.byKey(MenuDialogKeys.linkedIn),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MenuDialogKeys.linkedIn));

  expect(
    find.byKey(MenuDialogKeys.facebook),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MenuDialogKeys.facebook));

  expect(
    find.byKey(MenuDialogKeys.instagram),
    findsOneWidget,
  );

  await tester.tap(find.byKey(MenuDialogKeys.instagram));
}

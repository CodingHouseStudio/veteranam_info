import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> singUpNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.login.signUpButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.login.signUpButton,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.login.signUpButton));

  verify(() => mockGoRouter.go(KRoute.signUp.path)).called(1);
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../text_dependency.dart';

Future<void> loginNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.signUp.loginButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.signUp.loginButton));

  verify(() => mockGoRouter.go(KRoute.login.path)).called(1);
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> signUpNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.signUp.loginButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.signUp.loginButton));

  verify(() => mockGoRouter.goNamed(KRoute.login.name)).called(1);
}

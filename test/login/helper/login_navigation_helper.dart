import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> loginNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(LoginKeys.signUpButton),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: LoginKeys.signUpButton,
  );

  await tester.tap(find.byKey(LoginKeys.signUpButton));

  verify(() => mockGoRouter.goNamed(KRoute.signUp.name)).called(1);
}

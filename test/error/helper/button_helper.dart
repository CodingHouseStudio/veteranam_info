import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> buttonHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required String routeName,
}) async {
  expect(
    find.byKey(ErrorKeys.button),
    findsOneWidget,
  );

  await tester.tap(find.byKey(ErrorKeys.button));

  verify(
    () => mockGoRouter.goNamed(
      routeName,
    ),
  ).called(1);
}

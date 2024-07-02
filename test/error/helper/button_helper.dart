import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> buttonHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.error.button),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.error.button));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.home.name,
    ),
  ).called(1);
}

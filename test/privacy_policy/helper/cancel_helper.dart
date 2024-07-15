import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> cancelHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.icon),
    findsWidgets,
  );

  await tester.tap(find.byKey(KWidgetkeys.screen.privacyPolicy.icon));

  verify(
    () => mockGoRouter.pop(),
  ).called(1);
}

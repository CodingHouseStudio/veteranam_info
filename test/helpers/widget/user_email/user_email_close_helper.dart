import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> userEmailCloseHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await userEmailHelper(tester);

  expect(find.byKey(KWidgetkeys.widget.userEmailDialog.icon), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.userEmailDialog.icon));

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.pop(),
  ).called(1);
}
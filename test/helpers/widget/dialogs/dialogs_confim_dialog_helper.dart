import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dialogConfirmHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  bool isPop = true,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.confirmDialog.confirmButton));

  await tester.pumpAndSettle();

  if (isPop) {
    verify(() => mockGoRouter.pop()).called(1);
  }
}

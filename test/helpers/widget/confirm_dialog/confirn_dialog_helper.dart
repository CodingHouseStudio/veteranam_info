import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> confirmDialogHelper({
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

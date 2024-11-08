import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> confirmDialogUnconfirmHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.unconfirmButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.confirmDialog.unconfirmButton));

  await tester.pumpAndSettle();

  verify(() => mockGoRouter.pop()).called(1);
}

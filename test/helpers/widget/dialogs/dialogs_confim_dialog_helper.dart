import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dialogConfirmHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.dialogs.confirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.dialogs.confirmButton));

  await tester.pumpAndSettle();

  verify(() => mockGoRouter.pop()).called(1);
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> dialogDeleteAccountConfirmHelper({
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

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> dialogCancelIconHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.icon),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.confirmDialog.icon));

  await tester.pumpAndSettle();

  verify(() => mockGoRouter.pop()).called(1);
}

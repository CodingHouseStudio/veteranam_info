import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogUnconfirmHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.dialogs.unconfirmButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.dialogs.unconfirmButton));

  await tester.pumpAndSettle();

  // verify(() => mockGoRouter.pop()).called(1);
}
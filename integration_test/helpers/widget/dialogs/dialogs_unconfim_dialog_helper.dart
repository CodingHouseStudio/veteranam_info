import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> dialogUnconfirmHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.confirmDialog.unconfirmButton),
    findsOneWidget,
  );

  await tester
      .tap(find.byKey(KWidgetkeys.widget.confirmDialog.unconfirmButton));

  await tester.pumpAndSettle();

  // verify(() => mockGoRouter.pop()).called(1);
}

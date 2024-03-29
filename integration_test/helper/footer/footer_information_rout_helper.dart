import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> footerInformationRoutHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.footerKeys.informationButton), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.footerKeys.informationButton));

  await tester.pumpAndSettle();
}

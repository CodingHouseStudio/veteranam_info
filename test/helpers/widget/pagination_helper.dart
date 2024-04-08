import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> paginationTest(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.pagination.buttonPrevious),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.pagination.buttonNext),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.pagination.buttonPrevious));

  await tester.pumpAndSettle();

  expect(find.text(KAppText.previousPage), findsOneWidget);
  expect(find.text(KAppText.nextPage), findsOneWidget);

  await tester.tap(find.byKey(KWidgetkeys.widget.pagination.buttonNext));

  await tester.pumpAndSettle();

  expect(find.text(KAppText.previousPage), findsOneWidget);
  expect(find.text(KAppText.nextPage), findsOneWidget);
}

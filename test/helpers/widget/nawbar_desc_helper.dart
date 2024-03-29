import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> nawbarDescHelper({
  required WidgetTester tester,
  required String searchText,
}) async {
  expect(find.byKey(KWidgetkeys.searchKeys.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.searchKeys.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.searchKeys.micIcon), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.searchKeys.button),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.searchKeys.personIcon), findsOneWidget);

  await tester.enterText(find.byKey(KWidgetkeys.searchKeys.field), searchText);
}

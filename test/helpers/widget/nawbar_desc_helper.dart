import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> nawbarDescHelper({
  required WidgetTester tester,
  required String searchText,
}) async {
  expect(find.byKey(KWidgetkeys.nawbarKeys.title), findsOneWidget);

  expect(find.byKey(KWidgetkeys.nawbarKeys.field), findsOneWidget);

  expect(find.byKey(KWidgetkeys.nawbarKeys.micIcon), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.nawbarKeys.button),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.nawbarKeys.personIcon), findsOneWidget);

  await tester.enterText(find.byKey(KWidgetkeys.nawbarKeys.field), searchText);
}

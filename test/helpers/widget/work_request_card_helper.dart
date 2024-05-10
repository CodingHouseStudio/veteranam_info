import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> workRequestCardHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.workRequestCard.title), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.workRequestCard.subtitle), findsWidgets);

  expect(find.byKey(KWidgetkeys.widget.workRequestCard.button), findsWidgets);
}

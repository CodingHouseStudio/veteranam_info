import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

Future<void> statisticBoxHelper({
  required WidgetTester tester,
}) async {
  expect(find.byKey(KWidgetkeys.widget.statisticBox.title), findsWidgets);

  expect(
    find.byKey(KWidgetkeys.widget.statisticBox.subtitle),
    findsWidgets,
  );
}

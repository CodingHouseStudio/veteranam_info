import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> statisticBoxHelper({
  required WidgetTester tester,
}) async {
  expect(find.byKey(StatisticBoxKeys.title), findsWidgets);

  expect(
    find.byKey(StatisticBoxKeys.subtitle),
    findsWidgets,
  );
}

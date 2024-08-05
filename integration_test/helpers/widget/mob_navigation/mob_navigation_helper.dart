import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> mobNavigationHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.widget.mobNavigation.widget), findsOneWidget);

  expect(
    find.byKey(KWidgetkeys.widget.mobNavigation.discounts),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.mobNavigation.investors),
    findsOneWidget,
  );

  expect(find.byKey(KWidgetkeys.widget.mobNavigation.settings), findsOneWidget);
}

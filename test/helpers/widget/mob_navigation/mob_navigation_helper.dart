import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> mobNavigationHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(MobNavigationKeys.widget), findsOneWidget);

  expect(
    find.byKey(MobNavigationKeys.discounts),
    findsOneWidget,
  );

  expect(
    find.byKey(MobNavigationKeys.investors),
    findsOneWidget,
  );

  expect(find.byKey(MobNavigationKeys.settings), findsOneWidget);
}

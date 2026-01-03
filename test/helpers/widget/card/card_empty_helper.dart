import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> cardEmptyHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(CardEmptyKeys.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(CardEmptyKeys.closeButton),
    findsOneWidget,
  );

  expect(
    find.byKey(CardEmptyKeys.image),
    findsOneWidget,
  );

  expect(
    find.byKey(CardEmptyKeys.text),
    findsOneWidget,
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> cardEmptyHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.widget.cardEmpty.widget),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardEmpty.closeButton),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardEmpty.image),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.widget.cardEmpty.text),
    findsOneWidget,
  );
}

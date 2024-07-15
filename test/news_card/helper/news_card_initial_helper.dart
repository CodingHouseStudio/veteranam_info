import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> newsCardInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.newsCard.widget),
    findsWidgets,
  );

  expect(
    find.byKey(KWidgetkeys.screen.newsCard.closeButton),
    findsWidgets,
  );
}

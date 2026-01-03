import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountCardInitialHelper({
  required WidgetTester tester,
  bool cardIsEmpty = false,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    scrollUp: false,
    test: () async {
      final matcher = cardIsEmpty ? findsNothing : findsOneWidget;

      expect(
        find.byKey(DiscountCardDialogKeys.widget),
        matcher,
      );

      expect(
        find.byKey(DiscountCardDialogKeys.closeButton),
        matcher,
      );

      if (cardIsEmpty) {
        await cardEmptyHelper(tester);
      } else {
        await discountCardHelper(tester: tester);
      }
    },
  );
}

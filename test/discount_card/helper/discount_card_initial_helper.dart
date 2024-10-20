import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

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
        find.byKey(KWidgetkeys.screen.discountCard.widget),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discountCard.closeButton),
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

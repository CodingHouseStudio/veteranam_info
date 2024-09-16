import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../helpers/helpers.dart';

Future<void> newsCardInitialHelper({
  required WidgetTester tester,
  bool cardIsEmpty = false,
}) async {
  await changeWindowSizeHelper(
    windowsTest: true,
    scrollUp: false,
    tester: tester,
    test: () async {
      final matcher = cardIsEmpty ? findsNothing : findsOneWidget;
      expect(
        find.byKey(KWidgetkeys.screen.newsCard.widget),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.newsCard.closeButton),
        matcher,
      );

      if (cardIsEmpty) {
        await cardEmptyHelper(tester);
      } else {
        await newsCardHelper(tester: tester);
      }
    },
  );
}

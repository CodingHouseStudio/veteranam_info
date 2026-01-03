import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> discountsEditIdWrongInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(DiscountsAddKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(DiscountsAddKeys.textWrongLink),
        findsOneWidget,
      );

      expect(
        find.byKey(DiscountsAddKeys.imageWrongLink),
        findsOneWidget,
      );

      expect(
        find.byKey(DiscountsAddKeys.pageIndicator),
        findsNothing,
      );

      expect(
        find.byKey(DiscountsAddKeys.buttonWrongLink),
        findsOneWidget,
      );
    },
  );
}

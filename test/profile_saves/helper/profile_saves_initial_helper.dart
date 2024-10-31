import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> profileSavesInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.profileSaves.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profileSaves.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profileSaves.discountCard),
        findsOneWidget,
      );
    },
  );
}

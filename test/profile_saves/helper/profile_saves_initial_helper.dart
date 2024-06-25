import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../helpers/change_window_size_helper.dart';

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

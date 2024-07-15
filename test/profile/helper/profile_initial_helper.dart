import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../helpers/change_window_size_helper.dart';

Future<void> profileInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.screen.profile.profileCard),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.title),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.profile.subtitle),
        findsOneWidget,
      );
    },
  );
}

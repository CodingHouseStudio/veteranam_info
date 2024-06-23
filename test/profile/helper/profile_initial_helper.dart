import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/constants/constants.dart';

import '../../helpers/change_window_size_helper.dart';

Future<void> profileInitialHelper(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
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

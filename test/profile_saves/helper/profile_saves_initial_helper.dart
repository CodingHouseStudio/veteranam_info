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
        find.byKey(ProfileSavesKeys.title),
        findsOneWidget,
      );

      expect(
        find.byKey(ProfileSavesKeys.subtitle),
        findsOneWidget,
      );

      expect(
        find.byKey(ProfileSavesKeys.discountCard),
        findsOneWidget,
      );
    },
  );
}

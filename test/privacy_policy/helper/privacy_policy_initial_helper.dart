import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> privacyPolicyInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.text),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.closeIcon),
    findsOneWidget,
  );
}

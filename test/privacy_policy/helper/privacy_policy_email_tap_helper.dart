import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> privacyPolicyEmailTapHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.privacyPolicy.text),
    findsOneWidget,
  );

  expect(
    find.textContaining(KAppText.email),
    findsWidgets,
  );

  await tester.tap(
    find.textContaining(KAppText.email).first,
    warnIfMissed: false,
  );

  await tester.pumpAndSettle();
}

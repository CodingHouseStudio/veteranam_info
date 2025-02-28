import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared_flutter.dart';

import '../../../test_dependency.dart';

Future<void> privacyPolicyCookiesDialogHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(CookiesDialogKeys.dialog),
    findsOneWidget,
  );

  expect(
    find.byKey(CookiesDialogKeys.text),
    findsOneWidget,
  );

  await tester.tapOnTextCustom(
    text: 'Політику конфіденційності',
    englishText: 'Privacy Policy',
    last: true,
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.goNamed(KRoute.privacyPolicy.name),
  ).called(1);
}

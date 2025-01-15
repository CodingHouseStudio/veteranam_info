import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

Future<void> nawbarProfileNavigationHelper(WidgetTester tester) async {
  expect(
    find.byKey(NawbarKeys.loginIcon),
    findsOneWidget,
  );

  await tester.tap(find.byKey(NawbarKeys.loginIcon));

  // verify(
  //   () => mockGoRouter.goNamed(KRoute.profile.name),
  // ).called(1);
}

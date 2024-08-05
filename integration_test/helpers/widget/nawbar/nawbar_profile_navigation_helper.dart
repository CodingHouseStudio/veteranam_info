import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

Future<void> nawbarProfileNavigationHelper(WidgetTester tester) async {
  expect(
    find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.loginIcon));

  // verify(
  //   () => mockGoRouter.goNamed(KRoute.profile.name),
  // ).called(1);
}

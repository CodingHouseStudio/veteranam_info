import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/constants/route_constants.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> nawbarProfileNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.nawbar.loginIcon),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.loginIcon));

  verify(
    () => mockGoRouter.goNamed(KRoute.profile.name),
  ).called(1);
}

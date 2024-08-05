import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> nawbarTitleHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.nawbar.logo),
    findsOneWidget,
  );

  // for (var i = 0; i < 10; i++) {
  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.logo),
    warnIfMissed: false,
  );
  // }

  // await tester.pumpAndSettle(const Duration(milliseconds: 500));

  verify(
    () => mockGoRouter.goNamed(
      KRoute.home.name,
    ),
  ).called(1);
}

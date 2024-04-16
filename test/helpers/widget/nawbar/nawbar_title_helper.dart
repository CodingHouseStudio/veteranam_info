import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> nawbarTitleHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    itemKey: null,
  );

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.title),
    findsOneWidget,
  );

  for (var i = 0; i < 10; i++) {
    await tester.tap(
      find.byKey(KWidgetkeys.widget.nawbar.title),
    );
  }

  await tester.pumpAndSettle(const Duration(milliseconds: 500));

  verify(
    () => mockGoRouter.go(
      KRoute.home.path,
    ),
  ).called(1);
}

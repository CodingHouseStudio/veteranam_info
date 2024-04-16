import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> nawbarLoginNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  await scrollingHelper(
    tester: tester,
    offset: KTestConstants.scrollingUp,
    itemKey: null,
  );

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.iconPerson),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.iconPerson),
  );

  await tester.pump();

  verify(
    () => mockGoRouter.go(
      KRoute.login.path,
    ),
  ).called(1);

  await changeWindowSizeHelper(tester: tester);

  expect(
    find.byKey(KWidgetkeys.widget.nawbar.button),
    findsOneWidget,
  );

  await tester.tap(
    find.byKey(KWidgetkeys.widget.nawbar.button),
  );

  await tester.pumpAndSettle();

  verify(
    () => mockGoRouter.go(
      KRoute.login.path,
    ),
  ).called(1);

  await changeWindowSizeHelper(tester: tester, setDefaultSize: true);
}

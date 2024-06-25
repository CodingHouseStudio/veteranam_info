import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../text_dependency.dart';

Future<void> nawbarProfileNavigationHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.nawbar.iconPerson),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.widget.nawbar.iconPerson,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.nawbar.iconPerson));

  verify(
    () => mockGoRouter.goNamed(KRoute.profile.name),
  ).called(1);
}

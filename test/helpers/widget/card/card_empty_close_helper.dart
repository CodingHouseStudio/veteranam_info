import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> cardEmptyCloseHelper({
  required WidgetTester tester,
  required MockGoRouter mockGoRouter,
  required String routeName,
}) async {
  expect(
    find.byKey(KWidgetkeys.widget.cardEmpty.closeButton),
    findsOneWidget,
  );

  await tester.tap(find.byKey(KWidgetkeys.widget.cardEmpty.closeButton));

  verify(
    () => mockGoRouter.goNamed(routeName),
  ).called(1);
}
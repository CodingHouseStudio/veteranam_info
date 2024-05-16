import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> workRespondInitialHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.workRespond.title),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.subtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.username),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.emailText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.emailField),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.phoneNumberText),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.phoneNumberField),
    findsOneWidget,
  );

  await scrollingHelper(
    tester: tester,
    itemKey: KWidgetkeys.screen.workRespond.phoneNumberField,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.resume),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.upload),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.checkPoint),
    findsOneWidget,
  );

  await chekPointSingleHelper(tester);

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.noResume),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.send),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.workRespond.cancel),
    findsOneWidget,
  );
}

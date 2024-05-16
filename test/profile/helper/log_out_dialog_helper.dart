import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/constants/constants.dart';

import '../../text_dependency.dart';

Future<void> logOutDialoglHelper(
  WidgetTester tester,
) async {
  expect(
    find.byKey(KWidgetkeys.screen.profile.screen),
    findsOneWidget,
  );

  await tester.pumpAndSettle();

  await profileCardLogOutHelper(tester);
}

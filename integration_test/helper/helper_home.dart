import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/app/app.dart';
import 'package:kozak/shared/shared.dart';

import '../constants.dart';
import 'helper.dart';

Future<void> homeHelper(WidgetTester tester) async {
  await tester.pumpWidget(const App());

  expect(
    find.byKey(KWidgetkeys.screen.app.screen),
    findsOneWidget,
  );
  await tester.pumpAndSettle();

  await footerHelper(tester: tester, email: KTestText.useremail);
}

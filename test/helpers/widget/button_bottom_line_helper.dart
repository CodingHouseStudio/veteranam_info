import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../test_dependency.dart';

Future<void> buttonBottomLineHelper({
  required WidgetTester tester,
  required bool isDesk,
}) async {
  expect(find.byKey(KWidgetkeys.widget.buttonBottomLine.text), findsWidgets);

  if (isDesk) {
    await hoverHelper(
      tester: tester,
      key: KWidgetkeys.widget.buttonBottomLine.text,
      hoverElement: KWidgetkeys.widget.buttonBottomLine.line,
    );
  }
}
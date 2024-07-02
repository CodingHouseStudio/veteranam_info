import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> feedbackBoxHelper({
  required WidgetTester tester,
  required bool exist,
}) async {
  final matcher = exist ? findsOneWidget : findsNothing;

  expect(find.byKey(KWidgetkeys.screen.feedback.boxTitle), matcher);

  expect(find.byKey(KWidgetkeys.screen.feedback.boxSubtitle), matcher);

  expect(find.byKey(KWidgetkeys.screen.feedback.boxButton), matcher);

  expect(find.byKey(KWidgetkeys.screen.feedback.boxInformationBox), matcher);

  if (exist) {
    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.screen.feedback.boxInformationBox,
    );
  }

  expect(find.byKey(KWidgetkeys.screen.feedback.boxInvestorsBox), matcher);

  expect(find.byKey(KWidgetkeys.screen.feedback.boxStoryBox), matcher);

  if (exist) {
    await boxHelper(tester);
  }
}

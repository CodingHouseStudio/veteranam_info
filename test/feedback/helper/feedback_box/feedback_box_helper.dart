import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> feedbackBoxHelper({
  required WidgetTester tester,
  required bool exist,
}) async {
  final matcher = exist ? findsOneWidget : findsNothing;

  expect(find.byKey(KWidgetkeys.screen.feedback.boxSocialMedia), matcher);

  expect(find.byKey(KWidgetkeys.screen.feedback.boxText), matcher);

  expect(find.byKey(KWidgetkeys.screen.feedback.boxBackButton), matcher);

  expect(find.byKey(KWidgetkeys.screen.feedback.boxButton), matcher);

  //expect(find.byKey(KWidgetkeys.screen.feedback.boxInformationBox), matcher);

  // if (exist) {
  //   await scrollingHelper(
  //     tester: tester,
  //     itemKey: KWidgetkeys.screen.feedback.boxInformationBox,
  //   );
  // }

  // expect(find.byKey(KWidgetkeys.screen.feedback.boxInvestorsBox), matcher);

  // expect(find.byKey(KWidgetkeys.screen.feedback.boxStoryBox), matcher);

  if (exist) {
    //await boxHelper(tester);

    await scrollingHelper(
      tester: tester,
      itemKey: KWidgetkeys.screen.feedback.boxButton,
    );

    await tester.tap(find.byKey(KWidgetkeys.screen.feedback.boxButton));

    await tester.pumpAndSettle();

    await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

    await feedbackFormInitialHelper(tester);
  }
}

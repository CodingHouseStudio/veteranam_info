import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';
import '../helper.dart';

Future<void> feedbackBoxHelper({
  required WidgetTester tester,
  required bool exist,
}) async {
  final matcher = exist ? findsOneWidget : findsNothing;

  expect(find.byKey(FeedbackKeys.boxSocialMedia), matcher);

  expect(find.byKey(FeedbackKeys.boxText), matcher);

  expect(find.byKey(FeedbackKeys.boxBackButton), matcher);

  expect(find.byKey(FeedbackKeys.boxButton), matcher);

  //expect(find.byKey(FeedbackKeys.boxInformationBox), matcher);

  // if (exist) {
  //   await scrollingHelper(
  //     tester: tester,
  //     itemKey: FeedbackKeys.boxInformationBox,
  //   );
  // }

  // expect(find.byKey(FeedbackKeys.boxInvestorsBox), matcher);

  // expect(find.byKey(FeedbackKeys.boxStoryBox), matcher);

  if (exist) {
    //await boxHelper(tester);

    await scrollingHelper(
      tester: tester,
      itemKey: FeedbackKeys.boxButton,
    );

    await tester.tap(find.byKey(FeedbackKeys.boxButton));

    await tester.pumpAndSettle();

    await scrollingHelper(tester: tester, offset: KTestConstants.scrollingUp);

    await feedbackFormInitialHelper(tester);
  }
}

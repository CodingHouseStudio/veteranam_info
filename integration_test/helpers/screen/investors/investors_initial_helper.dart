import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(InvestorsKeys.screen), findsOneWidget);

  if (Config.isWeb) {
    expect(find.byKey(InvestorsKeys.title), findsOneWidget);
    // expect(find.byKey(InvestorsKeys.point),
    // findsOneWidget);

    expect(
      find.byKey(InvestorsKeys.feedbackTitle),
      findsOneWidget,
    );
    await scrollingHelperInt(
      tester: tester,
      itemKey: InvestorsKeys.feedbackTitle,
    );

    expect(
      find.byKey(InvestorsKeys.feedbackSubtitle),
      findsOneWidget,
    );

    expect(
      find.byKey(InvestorsKeys.feedbackButton),
      findsOneWidget,
    );

    expect(
      find.byKey(InvestorsKeys.rightImages),
      findsOneWidget,
    );

    expect(
      find.byKey(InvestorsKeys.leftImages),
      findsOneWidget,
    );

    await scrollingHelperInt(
      tester: tester,
      itemKey: InvestorsKeys.leftImages,
    );
  } else {
    expect(
      find.byKey(NawbarKeys.pageName),
      findsOneWidget,
    );
  }

  expect(
    find.byKey(InvestorsKeys.fundsTitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: InvestorsKeys.fundsTitle,
  );

  expect(
    find.byKey(InvestorsKeys.fundsTitle),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(InvestorsKeys.buttonMock),
  //   findsNothing,
  // );

  expect(
    find.byKey(InvestorsKeys.card),
    findsWidgets,
  );

  // await reportDialogInitialHelper(tester);

  // await scrollingHelper(
  //   tester: tester,
  //   offset: KTestConstants.scrollingDown,
  // );

  // expect(
  //   find.byKey(InvestorsKeys.button),
  //   findsWidgets,
  // );
  if (find.byKey(DonateCardKeys.subtitle).evaluate().isNotEmpty) {
    await donateCardHelper(tester: tester, isDesk: false);
  } else {
    await donatesCardHelper(tester);
  }
}

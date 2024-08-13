import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/shared.dart';

import '../../../test_dependency.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.investors.title), findsOneWidget);

  if (KTest.testIsWeb) {
    // expect(find.byKey(KWidgetkeys.screen.investors.point), findsOneWidget);

    expect(
      find.byKey(KWidgetkeys.screen.investors.feedbackTitle),
      findsOneWidget,
    );
    await scrollingHelperInt(
      tester: tester,
      itemKey: KWidgetkeys.screen.investors.feedbackTitle,
    );

    expect(
      find.byKey(KWidgetkeys.screen.investors.feedbackSubtitle),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.screen.investors.feedbackButton),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.screen.investors.rightImages),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.screen.investors.leftImages),
      findsOneWidget,
    );

    await scrollingHelperInt(
      tester: tester,
      itemKey: KWidgetkeys.screen.investors.leftImages,
    );
  }

  expect(
    find.byKey(KWidgetkeys.screen.investors.fundsTitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.investors.fundsTitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.investors.fundsTitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.investors.buttonMock),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.investors.card),
    findsWidgets,
  );

  // await reportDialogInitialHelper(tester);

  // await scrollingHelper(
  //   tester: tester,
  //   offset: KTestConstants.scrollingDown,
  // );

  // expect(
  //   find.byKey(KWidgetkeys.screen.investors.button),
  //   findsWidgets,
  // );
  if (find
      .byKey(KWidgetkeys.widget.donateCard.subtitle)
      .evaluate()
      .isNotEmpty) {
    await donateCardHelper(tester: tester, isDesk: false);
  } else {
    await donatesCardHelper(tester);
  }
}

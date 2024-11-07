import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../../test_dependency.dart';

Future<void> investorsInitialHelper(
  WidgetTester tester,
) async {
  expect(find.byKey(KWidgetkeys.screen.investors.screen), findsOneWidget);

  if (Config.isWeb) {
    expect(find.byKey(KWidgetkeys.screen.investors.title), findsOneWidget);
    // expect(find.byKey(KWidgetkeys.screen.investors.point),
    // findsOneWidget);

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
  } else {
    expect(
      find.byKey(KWidgetkeys.widget.nawbar.pageName),
      findsOneWidget,
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

  // expect(
  //   find.byKey(KWidgetkeys.screen.investors.buttonMock),
  //   findsNothing,
  // );

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

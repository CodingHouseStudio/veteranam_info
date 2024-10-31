import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> homeInitialHelper(
  WidgetTester tester,
) async {
  await nawbarHelper(tester: tester, searchText: KTestText.field);

  expect(
    find.byKey(KWidgetkeys.screen.home.box),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.home.boxIcon),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(KWidgetkeys.screen.home.boxSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.boxTitle),
    findsOneWidget,
  );

  await boxHelper(tester);

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.widget.box.text,
    first: false,
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.home.aboutProjecPrefix),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(KWidgetkeys.screen.home.aboutProjecSubtitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.aboutProjecSubtitle,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown100,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.discountImage),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.discountImage,
  );

  // expect(
  //   find.byKey(KWidgetkeys.screen.home.discountPrefix),
  //   findsOneWidget,
  // );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.discountTitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.discountTitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.discountTitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.discountSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.discountButton),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.discountButton,
  );

  if (Config.isDevelopment) {
    expect(
      find.byKey(KWidgetkeys.screen.home.informationImage),
      findsOneWidget,
    );

    await scrollingHelperInt(
      tester: tester,
      itemKey: KWidgetkeys.screen.home.informationImage,
    );

    // expect(
    //   find.byKey(KWidgetkeys.screen.home.informationPrefix),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(KWidgetkeys.screen.home.informationTitle),
      findsOneWidget,
    );

    expect(
      find.byKey(KWidgetkeys.screen.home.informationSubtitle),
      findsOneWidget,
    );

    await scrollingHelperInt(
      tester: tester,
      itemKey: KWidgetkeys.screen.home.informationSubtitle,
    );

    expect(
      find.byKey(KWidgetkeys.screen.home.informationButton),
      findsOneWidget,
    );
  }

  // expect(
  //   find.byKey(KWidgetkeys.screen.home.faqPrefix),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(KWidgetkeys.screen.home.faqTitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.faqTitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.faqSubtitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: KWidgetkeys.screen.home.faqSubtitle,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.buttonMock),
    findsNothing,
  );

  expect(
    find.byKey(KWidgetkeys.screen.home.faq),
    findsWidgets,
  );

  await questionHelper(tester);

  await dialogFailureGetHelper(tester: tester, isFailure: false);

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown,
  );

  await footerHelper(tester);
}

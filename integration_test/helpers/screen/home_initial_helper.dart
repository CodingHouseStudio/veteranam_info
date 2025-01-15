import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> homeInitialHelper(
  WidgetTester tester,
) async {
  await nawbarHelper(tester: tester, searchText: KTestText.field);

  expect(
    find.byKey(HomeKeys.box),
    findsOneWidget,
  );

  // expect(
  //   find.byKey(HomeKeys.boxIcon),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(HomeKeys.boxSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(HomeKeys.boxTitle),
    findsOneWidget,
  );

  await boxHelper(tester);

  await scrollingHelperInt(
    tester: tester,
    itemKey: BoxKeys.text,
    first: false,
  );

  // expect(
  //   find.byKey(HomeKeys.aboutProjecPrefix),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(HomeKeys.aboutProjecSubtitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: HomeKeys.aboutProjecSubtitle,
  );

  await scrollingHelperInt(
    tester: tester,
    offset: KTestConstants.scrollingDown100,
  );

  expect(
    find.byKey(HomeKeys.discountImage),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: HomeKeys.discountImage,
  );

  // expect(
  //   find.byKey(HomeKeys.discountPrefix),
  //   findsOneWidget,
  // );

  await scrollingHelperInt(
    tester: tester,
    itemKey: HomeKeys.discountTitle,
  );

  expect(
    find.byKey(HomeKeys.discountTitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: HomeKeys.discountTitle,
  );

  expect(
    find.byKey(HomeKeys.discountSubtitle),
    findsOneWidget,
  );

  expect(
    find.byKey(HomeKeys.discountButton),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: HomeKeys.discountButton,
  );

  if (Config.isDevelopment) {
    expect(
      find.byKey(HomeKeys.informationImage),
      findsOneWidget,
    );

    await scrollingHelperInt(
      tester: tester,
      itemKey: HomeKeys.informationImage,
    );

    // expect(
    //   find.byKey(HomeKeys.informationPrefix),
    //   findsOneWidget,
    // );

    expect(
      find.byKey(HomeKeys.informationTitle),
      findsOneWidget,
    );

    expect(
      find.byKey(HomeKeys.informationSubtitle),
      findsOneWidget,
    );

    await scrollingHelperInt(
      tester: tester,
      itemKey: HomeKeys.informationSubtitle,
    );

    expect(
      find.byKey(HomeKeys.informationButton),
      findsOneWidget,
    );
  }

  // expect(
  //   find.byKey(HomeKeys.faqPrefix),
  //   findsOneWidget,
  // );

  expect(
    find.byKey(HomeKeys.faqTitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: HomeKeys.faqTitle,
  );

  expect(
    find.byKey(HomeKeys.faqSubtitle),
    findsOneWidget,
  );

  await scrollingHelperInt(
    tester: tester,
    itemKey: HomeKeys.faqSubtitle,
  );

  expect(
    find.byKey(HomeKeys.buttonMock),
    findsNothing,
  );

  expect(
    find.byKey(HomeKeys.faq),
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

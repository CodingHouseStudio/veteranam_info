import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> homeInitialHelper(
  WidgetTester tester,
) async {
  await nawbarHelper(
    tester: tester,
    searchText: KTestText.field,
  );

  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
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

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.box.text,
        first: false,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.aboutProjecPrefix),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.aboutProjecSubtitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.aboutProjecSubtitle,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.discountImage),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.discountImage,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.discountPrefix),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.discountTitle),
        findsOneWidget,
      );

      await scrollingHelper(
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

      expect(
        find.byKey(KWidgetkeys.screen.home.informationImage),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.informationImage,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.informationPrefix),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.informationTitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.informationSubtitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.home.informationSubtitle,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.informationButton),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.faqPrefix),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.faqTitle),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.screen.home.faqSubtitle),
        findsOneWidget,
      );

      await scrollingHelper(
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

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await footerHelper(tester);
    },
  );
}

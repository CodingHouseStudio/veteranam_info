import 'package:flutter/widgets.dart' show ScrollPositionAlignmentPolicy;
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';
import 'helper.dart';

Future<void> homeInitialHelper(
  WidgetTester tester,
) async {
  await homeChangeWindowSizeHelper(
    isMobile: true,
    tabletTest: true,
    tester: tester,
    test: () async {
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      await nawbarHelper(tester: tester, searchText: KTestVariables.field);

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

      await doubleButtonHelper(tester);

      await boxHelper(tester);

      await scrollingHelper(
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

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.aboutProjecSubtitle,
      );

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown100,
      );

      expect(
        find.byKey(HomeKeys.discountImage),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.discountImage,
      );

      // expect(
      //   find.byKey(HomeKeys.discountPrefix),
      //   findsOneWidget,
      // );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.discountTitle,
      );

      expect(
        find.byKey(HomeKeys.discountTitle),
        findsOneWidget,
      );

      await scrollingHelper(
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

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.discountButton,
      );

      if (Config.isDevelopment) {
        expect(
          find.byKey(HomeKeys.informationImage),
          findsOneWidget,
        );

        await scrollingHelper(
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

        await scrollingHelper(
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

      // await scrollingHelper(
      //   tester: tester,
      //   itemKey: HomeKeys.faqTitle,
      //   elementScrollAligment: 0.9,
      // );

      // expect(
      //   find.byKey(HomeKeys.faqTitle),
      //   findsOneWidget,
      // );

      expect(
        find.byKey(HomeKeys.faqSubtitle),
        findsOneWidget,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: HomeKeys.faqSubtitle,
        scrollPositionAlignmentPolicy:
            ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );

      expect(
        find.byKey(HomeKeys.faqSubtitle),
        findsOneWidget,
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

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await footerHelper(tester);
    },
  );
}

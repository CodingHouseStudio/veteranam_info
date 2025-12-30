import 'package:flutter_test/flutter_test.dart';

import 'package:veteranam/shared/constants/config.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';
import '../../test_dependency.dart';

Future<void> discountInitialHelper({
  required WidgetTester tester,
  bool cardIsEmpty = false,
}) async {
  await changeWindowSizeHelper(
    tester: tester,
    windowsTest: true,
    scrollUp: false,
    test: () async {
      final matcher = cardIsEmpty ? findsNothing : findsOneWidget;

      expect(
        find.byKey(DiscountKeys.backButton),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.backText),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.companyInfo),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.title),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.city),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.expiration),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.phoneNumberHideButton),
        matcher,
      );

      if (Config.isUser) {
        expect(
          find.byKey(DiscountKeys.complaintButton),
          matcher,
        );
      }

      expect(
        find.byKey(DiscountKeys.websiteButton),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.shareButton),
        matcher,
      );

      if (!cardIsEmpty) {
        await scrollingHelper(
          tester: tester,
          itemKey: DiscountKeys.shareButton,
        );
      }

      expect(
        find.byKey(DiscountKeys.eligiblity),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.eligiblity),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.detail),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.detailText),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.requirments),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.requirmentsText),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.exclusions),
        matcher,
      );

      expect(
        find.byKey(DiscountKeys.image),
        findsNothing,
      );

      if (cardIsEmpty) {
        expect(
          find.byKey(DiscountKeys.invalidLinkTitle),
          findsOneWidget,
        );

        expect(
          find.byKey(DiscountKeys.invalidLinkDescription),
          findsOneWidget,
        );

        expect(
          find.byKey(DiscountKeys.invalidLinkBackButton),
          findsOneWidget,
        );
      }
      //   await cardEmptyHelper(tester);
      // } else {
      //   await discountCardHelper(tester: tester);
      // }
    },
  );
}

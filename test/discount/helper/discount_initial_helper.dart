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
        find.byKey(KWidgetkeys.screen.discount.backButton),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.backText),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.companyInfo),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.title),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.city),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.expiration),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.phoneNumberHideButton),
        matcher,
      );

      if (Config.isUser) {
        expect(
          find.byKey(KWidgetkeys.screen.discount.complaintButton),
          matcher,
        );
      }

      expect(
        find.byKey(KWidgetkeys.screen.discount.websiteButton),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.shareButton),
        matcher,
      );

      if (!cardIsEmpty) {
        await scrollingHelper(
          tester: tester,
          itemKey: KWidgetkeys.screen.discount.shareButton,
        );
      }

      expect(
        find.byKey(KWidgetkeys.screen.discount.eligiblity),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.eligiblity),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.detail),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.detailText),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.requirments),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.requirmentsText),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.exclusions),
        matcher,
      );

      expect(
        find.byKey(KWidgetkeys.screen.discount.image),
        findsNothing,
      );

      if (cardIsEmpty) {
        expect(
          find.byKey(KWidgetkeys.screen.discount.invalidLinkTitle),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.discount.invalidLinkDescription),
          findsOneWidget,
        );

        expect(
          find.byKey(KWidgetkeys.screen.discount.invalidLinkBackButton),
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

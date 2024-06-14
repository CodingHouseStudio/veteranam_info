import 'package:flutter_test/flutter_test.dart';
import 'package:kozak/shared/shared.dart';

import '../../text_dependency.dart';

Future<void> listLoadHelper(
  WidgetTester tester,
) async {
  KDimensions.investorsLoadItems = 1;
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.button,
        offset: KTestConstants.scrollingUp500,
      );

      expect(find.byKey(KWidgetkeys.screen.investors.button), findsOneWidget);

      await tester.tap(find.byKey(KWidgetkeys.screen.investors.button));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingUp,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.feedbackTitle,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.leftImages,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.screen.investors.fundsPoint,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.donateCard.title,
      );

      final widgets = find.byKey(KWidgetkeys.widget.donateCard.title);

      expect(widgets, findsWidgets);

      expect(
        widgets.evaluate().length,
        greaterThan(KDimensions.investorsLoadItems),
      );
    },
  );
}

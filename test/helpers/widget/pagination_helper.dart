import 'package:flutter_test/flutter_test.dart';
import 'package:veteranam/shared/constants/widget_keys/widget_keys.dart';

import '../../test_dependency.dart';

Future<void> paginationTest(
  WidgetTester tester,
) async {
  await changeWindowSizeHelper(
    tester: tester,
    test: () async {
      expect(
        find.byKey(KWidgetkeys.widget.pagination.buttonPrevious),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.buttonNext),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.sixthNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.numbers),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.pagination.sixthNumber,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.pagination.sixthNumber));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.numbers),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.sixthNumber),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.pagination.buttonPrevious,
      );

      await tester
          .tap(find.byKey(KWidgetkeys.widget.pagination.buttonPrevious));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.sixthNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.numbers),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.pagination.buttonNext,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.pagination.buttonNext));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.numbers),
        findsWidgets,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.sixthNumber),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.pagination.lastNumber,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.pagination.lastNumber));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.numbers),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: KWidgetkeys.widget.pagination.firstNumber,
      );

      await tester.tap(find.byKey(KWidgetkeys.widget.pagination.firstNumber));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.firstThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(KWidgetkeys.widget.pagination.numbers),
        findsWidgets,
      );
    },
  );
}

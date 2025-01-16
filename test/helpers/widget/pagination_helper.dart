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
        find.byKey(PaginationKeys.buttonPrevious),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.buttonNext),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.firstThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(PaginationKeys.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.sixthNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.numbers),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: PaginationKeys.sixthNumber,
      );

      await tester.tap(find.byKey(PaginationKeys.sixthNumber));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(PaginationKeys.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.firstThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.numbers),
        findsWidgets,
      );

      expect(
        find.byKey(PaginationKeys.sixthNumber),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: PaginationKeys.buttonPrevious,
      );

      await tester.tap(find.byKey(PaginationKeys.buttonPrevious));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(PaginationKeys.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.firstThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(PaginationKeys.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.sixthNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.numbers),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: PaginationKeys.buttonNext,
      );

      await tester.tap(find.byKey(PaginationKeys.buttonNext));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(PaginationKeys.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.firstThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.numbers),
        findsWidgets,
      );

      expect(
        find.byKey(PaginationKeys.sixthNumber),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: PaginationKeys.lastNumber,
      );

      await tester.tap(find.byKey(PaginationKeys.lastNumber));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(PaginationKeys.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.firstThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(PaginationKeys.numbers),
        findsWidgets,
      );

      await scrollingHelper(
        tester: tester,
        itemKey: PaginationKeys.firstNumber,
      );

      await tester.tap(find.byKey(PaginationKeys.firstNumber));

      await tester.pumpAndSettle();

      await scrollingHelper(
        tester: tester,
        offset: KTestConstants.scrollingDown,
      );

      expect(
        find.byKey(PaginationKeys.firstNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.firstThreePoint),
        findsNothing,
      );

      expect(
        find.byKey(PaginationKeys.lastNumber),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.lastThreePoint),
        findsOneWidget,
      );

      expect(
        find.byKey(PaginationKeys.numbers),
        findsWidgets,
      );
    },
  );
}
